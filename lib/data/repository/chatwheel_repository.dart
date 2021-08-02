import 'package:built_collection/built_collection.dart';
import 'package:flutter_dota_2_chatwheel/data/model/local/chatwheel_line.dart';
import 'package:flutter_dota_2_chatwheel/data/network/chatwheel_data_source.dart';
import 'package:flutter_dota_2_chatwheel/data/provider/base_provider.dart';
import 'package:flutter_dota_2_chatwheel/data/provider/chatwheel_line_provider.dart';

class ChatwheelRepository {
  final ChatwheelDataSource _chatwheelDataSource;
  final BaseProvider _provider;
  final int _perPage = 15;
  int _start = 0;

  ChatwheelRepository(this._chatwheelDataSource, this._provider);

  // init database
  void init() async {
    // open database connection
    await (_provider as ChatwheelLineProvider).open();
  }

  // Store chatwheel to database
  Future<Null> storeChatwheels() async {
    final chatwheelEvents = await _chatwheelDataSource.getChatwheelEvents();
    final List<ChatwheelLine> localLines = [];

    if (chatwheelEvents.events.length == 0)
      throw EmptyResultException('No chatwheels found');

    final _result = await (_provider as ChatwheelLineProvider).countAllLines();
    if (_result != null) {
      if (_result[0]['total'] == 0) {
        final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        chatwheelEvents.events.forEach((event) {
          event?.packs.forEach((pack) {
            pack.lines.forEach((line) {
              final ChatwheelLine localLine = ChatwheelLine((b) => b
                ..eventName = ''
                ..packName = ''
                ..line = line.line
                ..lineTranslate = line.lineTranslate ?? ''
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
    }
  }

  /// load all chatwheel from data source and save it to database
  /// and then return list of chatwheel_line from database
  Future<BuiltList<ChatwheelLine>> getLines() async {
    final lines =
        await (_provider as ChatwheelLineProvider).getLines(_start, _perPage);
    if (lines == null) throw EmptyResultException('Lines returns null');
    if (lines.isEmpty) {
      throw EmptyResultException('No chatwheel lines stored');
    }
    _start += _perPage;
    return lines;
  }

  Future<bool> updateLine(int id, String localPath) async {
    final isUpdated =
        await (_provider as ChatwheelLineProvider).updateLine(id, localPath);

    return isUpdated;
  }
}

class EmptyResultException implements Exception {
  final String message;

  EmptyResultException(this.message);
}
