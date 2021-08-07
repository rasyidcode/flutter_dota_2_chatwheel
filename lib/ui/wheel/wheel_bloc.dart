import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dota_2_chatwheel/data/model/local/chatwheel_line.dart';
import 'package:flutter_dota_2_chatwheel/data/repository/wheel_repository.dart';
import 'package:flutter_dota_2_chatwheel/ui/wheel/wheel_event.dart';
import 'package:flutter_dota_2_chatwheel/ui/wheel/wheel_state.dart';
import 'package:flutter_dota_2_chatwheel/utils/download_util.dart';
import 'package:flutter_dota_2_chatwheel/utils/permission_util.dart';
import 'package:flutter_dota_2_chatwheel/utils/storage_util.dart';
import 'package:permission_handler/permission_handler.dart';

class WheelBloc extends Bloc<WheelEvent, WheelState> {
  WheelBloc(this._wheelRepository, this._dio) : super(WheelState.initial());

  WheelRepository _wheelRepository;
  Dio _dio;

  void onWheelInit() {
    add(WheelInitiated());
  }

  @override
  Stream<WheelState> mapEventToState(WheelEvent event) async* {
    if (event is WheelInitiated) {
      yield WheelState.loading();
      _wheelRepository.init();

      try {
        await _wheelRepository.storeEightLines();

        final lines = await _wheelRepository.getLines();

        for (ChatwheelLine line in lines) {
          File? savedFile;
          if (await requestPermission(Permission.storage)) {
            savedFile = await getLineFileStorage(line.line);
          } else {
            yield WheelState.error('Need storage permission');
            break;
          }

          downloadLine(_dio, line.url, savedFile!.path);
        }

        yield WheelState.success(lines);
      } catch (_) {
        yield WheelState.error('something wrong occured');
      }
    }
  }
}
