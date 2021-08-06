import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dota_2_chatwheel/data/model/local/chatwheel_line.dart';
import 'package:flutter_dota_2_chatwheel/data/network/chatwheel_data_source.dart';
import 'package:flutter_dota_2_chatwheel/data/repository/chatwheel_repository.dart';
import 'package:flutter_dota_2_chatwheel/enums/wheel_position.dart';
import 'package:flutter_dota_2_chatwheel/extensions/element_extensions.dart';
import 'package:flutter_dota_2_chatwheel/ui/chat_wheel/chat_wheel_event.dart';
import 'package:flutter_dota_2_chatwheel/ui/chat_wheel/chat_wheel_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatWheelBloc extends Bloc<ChatWheelEvent, ChatWheelState> {
  final ChatwheelRepository _chatwheelRepository;
  final Dio _dio;

  ChatWheelBloc(this._chatwheelRepository, this._dio)
      : super(ChatWheelState.initial());

  String _downloadUrl = '';
  String _fileName = '';
  int? _downloadingId;
  int _downloadingIndex = -1;

  int _showInWheelLineIndex = -1;
  bool _showInWheel = false;
  WheelPosition _wheelPosition = WheelPosition.none;

  void onHomeInit() {
    add(ChatWheelInitiated());
  }

  void fetchNextPage() {
    add(ChatWheelNextPage());
  }

  void downloadChatwheel(
      {required String downloadUrl,
      required String fileName,
      required int downloadingIndex,
      int? downloadingId}) {
    _downloadUrl = downloadUrl;
    _fileName = fileName;
    _downloadingId = downloadingId;
    _downloadingIndex = downloadingIndex;
    add(ChatWheelDownload());
  }

  void updateDotChatwheel({
    required bool showInWheel,
    required WheelPosition wheelPosition,
    required int id,
  }) {
    _showInWheelLineIndex = id;
    _showInWheel = showInWheel;
    _wheelPosition = wheelPosition;
    add(ChatWheelUpdateShowInWheel());
  }

  void updateLocalPath(int id, String localPath) async {
    BuiltList<ChatwheelLine> newLines = BuiltList<ChatwheelLine>();
    bool isUpdated = await _chatwheelRepository.setLocalPath(id, localPath);
    if (isUpdated) {
      ChatwheelLine cl = state.lines[_downloadingIndex]
          .rebuild((b) => b..localPath = localPath);
      var preNewLines = state.lines.toBuilder();
      preNewLines[_downloadingIndex] = cl;
      newLines = preNewLines.build();
    }
  }

  @override
  Stream<ChatWheelState> mapEventToState(ChatWheelEvent event) async* {
    if (event is ChatWheelInitiated) {
      yield* mapInitEvent();
    } else if (event is ChatWheelNextPage) {
      yield* mapNextPageEvent();
    } else if (event is ChatWheelDownload) {
      yield* mapDownloadEvent();
    } else if (event is ChatWheelUpdateShowInWheel) {
      yield* mapUpdateLineShowInWheel();
    }
  }

  Stream<ChatWheelState> mapDownloadEvent() async* {
    yield ChatWheelState.downloading(state.lines, _downloadingId);
    try {
      File? savedFile;
      if (await Permission.storage.isGranted) {
        savedFile = await _handleStoragePermissionGranted();
      } else {
        PermissionStatus permissionStatus = await Permission.storage.request();
        if (permissionStatus == PermissionStatus.granted) {
          savedFile = await _handleStoragePermissionGranted();
        } else {
          yield ChatWheelState.downloadFail(state.lines, _downloadingId);
        }
      }

      if (savedFile != null) {
        await _dio.download(
          _downloadUrl,
          savedFile.path,
          onReceiveProgress: (val1, val2) {
            double progress = val1 / val2;
            print(progress);
          },
        );
        // update downloadedId chatwheel on database
        BuiltList<ChatwheelLine> newLines = BuiltList<ChatwheelLine>();
        if (_downloadingId != null) {
          bool isUpdated = await _chatwheelRepository.setLocalPath(
              _downloadingId!, savedFile.path);
          if (isUpdated) {
            ChatwheelLine cl = state.lines[_downloadingIndex]
                .rebuild((b) => b..localPath = savedFile?.path);
            var preNewLines = state.lines.toBuilder();
            preNewLines[_downloadingIndex] = cl;
            newLines = preNewLines.build();
          }
        } else {
          newLines = state.lines;
        }

        yield ChatWheelState.downloaded(newLines, _downloadingId);
      } else {
        yield ChatWheelState.downloadFail(state.lines, _downloadingId);
      }
    } catch (e) {
      yield ChatWheelState.downloadFail(state.lines, _downloadingId);
    }
  }

  Stream<ChatWheelState> mapInitEvent() async* {
    yield ChatWheelState.loading();
    _chatwheelRepository.init();

    try {
      await _chatwheelRepository.storeChatwheels();

      final lines = await _chatwheelRepository.getLines();
      yield ChatWheelState.success(lines);
    } on NoElementFoundException catch (e) {
      yield ChatWheelState.failure(e.message);
    } on UnhandledException catch (e) {
      yield ChatWheelState.failure(e.message);
    } on EmptyResultException catch (e) {
      yield ChatWheelState.failure(e.message);
    }
  }

  Stream<ChatWheelState> mapNextPageEvent() async* {
    try {
      final lines = await _chatwheelRepository.getLines();
      yield ChatWheelState.success(state.lines + lines);
    } on EmptyResultException catch (_) {
      yield state.rebuild((b) => b..hasReachedEndOfResults = true);
    }
  }

  Stream<ChatWheelState> mapUpdateLineShowInWheel() async* {
    yield ChatWheelState.showInWheelUpdating(state.lines);

    try {
      await Future.delayed(Duration(seconds: 2));
      await _chatwheelRepository.updateShowInWheel(
        wheelPosition: _wheelPosition,
        showInWheel: _showInWheel,
        id: _showInWheelLineIndex,
      );
      yield ChatWheelState.showInWheelUpdateDone(state.lines);
    } on ShowInWheelUpdateException catch (e) {
      yield ChatWheelState.showInWheelUpdateError(state.lines, e.message);
    } catch (_) {
      yield ChatWheelState.showInWheelUpdateError(
          state.lines, 'Something wrong occured');
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
}
