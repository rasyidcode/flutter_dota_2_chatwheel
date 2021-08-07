import 'package:built_collection/built_collection.dart';
import 'package:flutter_dota_2_chatwheel/constants/eight_wheels.dart';
import 'package:flutter_dota_2_chatwheel/data/model/local/chatwheel_line.dart'
    as local;
import 'package:flutter_dota_2_chatwheel/data/model/network/chatwheel_line.dart'
    as network;
import 'package:flutter_dota_2_chatwheel/data/provider/base_provider.dart';
import 'package:flutter_dota_2_chatwheel/data/provider/chatwheel_line_provider.dart';
import 'package:flutter_dota_2_chatwheel/exceptions/empty_result_exception.dart';
import 'package:flutter_dota_2_chatwheel/extensions/int_extensions.dart';

class WheelRepository {
  final BaseProvider _baseProvider;

  WheelRepository(this._baseProvider);

  void init() async {
    await (_baseProvider as ChatwheelLineProvider).open();
  }

  Future<Null> storeEightLines() async {
    BuiltList<network.ChatwheelLine> networkLines = eightWheels;
    final List<local.ChatwheelLine> localLines = [];

    final _result =
        await (_baseProvider as ChatwheelLineProvider).countAllLines();
    if (_result != null) {
      if (_result[0]['total'] == 0) {
        int index = 0;
        networkLines.forEach((line) {
          final local.ChatwheelLine localLine = local.ChatwheelLine((b) => b
            ..eventName = ''
            ..packName = ''
            ..line = line.line
            ..lineTranslate = line.lineTranslate ?? ''
            ..url = line.url
            ..localPath = ''
            ..showInWheel = true
            ..wheelPos = index.toWheelDotPosition()
            ..createdAt = 0
            ..updatedAt = 0);
          localLines.add(localLine);
          index++;
        });
      }
    }
  }

  Future<BuiltList<local.ChatwheelLine>> getLines() async {
    final lines = await (_baseProvider as ChatwheelLineProvider).getLines(0, 8);
    if (lines == null) throw EmptyResultException('Lines returns null');
    if (lines.isEmpty) {
      throw EmptyResultException('No chatwheel lines stored');
    }
    return lines;
  }
}
