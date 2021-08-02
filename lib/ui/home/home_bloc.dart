import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dota_2_chatwheel/data/network/chatwheel_data_source.dart';
import 'package:flutter_dota_2_chatwheel/data/repository/chatwheel_repository.dart';
import 'package:flutter_dota_2_chatwheel/extensions/element_extensions.dart';
import 'package:flutter_dota_2_chatwheel/ui/home/home_event.dart';
import 'package:flutter_dota_2_chatwheel/ui/home/home_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ChatwheelRepository _chatwheelRepository;
  final Dio _dio;
  String _downloadUrl = '';
  String _fileName = '';
  HomeBloc(this._chatwheelRepository, this._dio) : super(HomeState.initial());

  void onHomeInit() {
    add(HomeInitiated());
  }

  void fetchNextPage() {
    add(HomeNextPage());
  }

  void downloadChatwheel(
      {required String downloadUrl, required String fileName}) {
    _downloadUrl = downloadUrl;
    _fileName = fileName;
    add(HomeDownload());
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeInitiated) {
      yield* mapInitEvent();
    } else if (event is HomeNextPage) {
      yield* mapNextPageEvent();
    } else if (event is HomeDownload) {
      yield* mapDownloadEvent();
    }
  }

  Stream<HomeState> mapDownloadEvent() async* {
    try {
      File? savedFile;
      if (await Permission.storage.isGranted) {
        savedFile = await _handleStoragePermissionGranted();
      } else {
        PermissionStatus permissionStatus = await Permission.storage.request();
        if (permissionStatus == PermissionStatus.granted) {
          savedFile = await _handleStoragePermissionGranted();
        } else {
          yield HomeState.failure('Need storage permission, please accept');
        }
      }

      if (savedFile != null) {
        await _dio.download(
          _downloadUrl,
          savedFile.path,
          onReceiveProgress: (val1, val2) async* {
            double progress = val1 / val2;
            print(progress);
            yield HomeState.downloading(progress);
          },
        );
      } else {
        yield HomeState.failure('savedFile returns null');
      }
    } catch (e) {
      yield HomeState.failure('Download error');
    }
  }

  Future<File?> _handleStoragePermissionGranted() async {
    Directory? dir = await getExternalStorageDirectory();
    String newPath = "";

    List<String>? paths = dir?.path.split("/");
    if (paths != null) {
      for (int i = 1; i < paths.length; i++) {
        if (paths[i] != "Android")
          newPath += "/" + paths[i];
        else
          break;
      }

      newPath = newPath + "/FlutterDota2Chatwheel";
      dir = Directory(newPath);
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      String savedPath = dir.path + "/$_fileName.mp3";
      File saveFile = File(savedPath);
      return saveFile;
    }
  }

  Stream<HomeState> mapInitEvent() async* {
    yield HomeState.loading();
    _chatwheelRepository.init();

    try {
      await _chatwheelRepository.storeChatwheels();

      final lines = await _chatwheelRepository.getLines();
      yield HomeState.success(lines);
    } on NoElementFoundException catch (e) {
      yield HomeState.failure(e.message);
    } on UnhandledException catch (e) {
      yield HomeState.failure(e.message);
    } on EmptyResultException catch (e) {
      yield HomeState.failure(e.message);
    }
  }

  Stream<HomeState> mapNextPageEvent() async* {
    try {
      final lines = await _chatwheelRepository.getLines();
      yield HomeState.success(state.lines + lines);
    } on EmptyResultException catch (_) {
      yield state.rebuild((b) => b..hasReachedEndOfResults = true);
    }
  }
}
