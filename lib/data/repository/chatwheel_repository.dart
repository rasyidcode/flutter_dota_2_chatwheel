import 'package:built_collection/built_collection.dart';
import 'package:flutter_dota_2_chatwheel/data/model/network/chatwheel_event.dart';
import 'package:flutter_dota_2_chatwheel/data/model/local/chatwheel_line.dart';
import 'package:flutter_dota_2_chatwheel/data/network/chatwheel_data_source.dart';
import 'package:flutter_dota_2_chatwheel/data/provider/base_provider.dart';
import 'package:flutter_dota_2_chatwheel/data/provider/chatwheel_line_provider.dart';

class ChatwheelRepository {
  final ChatwheelDataSource _chatwheelDataSource;
  final BaseProvider _provider;

  ChatwheelRepository(this._chatwheelDataSource, this._provider);

  // play song from internet
  // return BuiltList<ChatwheelEvent>
  Future<BuiltList<ChatwheelEvent?>> loadChatwheelEvents() async {
    final chatwheelEvents = await _chatwheelDataSource.getChatwheelEvents();

    if (chatwheelEvents.events.length == 0) throw EmptyResultException();

    return chatwheelEvents.events;
  }

  /// load all chatwheel from data source and save it to database
  /// and then return list of chatwheel_line from database
  Future<BuiltList<ChatwheelLine>> loadChatwheelLines(
      {required int start, int perPage = 10}) async {
    final chatwheelEvents = await _chatwheelDataSource.getChatwheelEvents();
    final List<ChatwheelLine> localLines = [];

    if (chatwheelEvents.events.length == 0) throw EmptyResultException();

    final _result = await (_provider as ChatwheelLineProvider).countAllLines();
    if (_result[0]['total'] == 0) {
      chatwheelEvents.events.forEach((event) {
        event?.packs.forEach((pack) {
          pack.lines.forEach((line) {
            final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
            final ChatwheelLine localLine = ChatwheelLine((b) => b
              ..eventName = event.eventName
              ..packName = pack.packName
              ..line = line.line
              ..lineTranslate = line.lineTranslate
              ..url = line.url
              ..localPath = ''
              ..createdAt = currentTime
              ..updatedAt = currentTime);
            localLines.add(localLine);
          });
        });
      });

      final filteredLocalLines = localLines.toSet().toList();

      await (_provider as ChatwheelLineProvider)
          .insertBatch(filteredLocalLines);
    }

    return await (_provider as ChatwheelLineProvider).getLines(start, perPage);
  }
}

class EmptyResultException implements Exception {
  final String message = 'No chatwheels found';
}
