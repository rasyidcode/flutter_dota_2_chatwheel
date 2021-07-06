import 'package:built_collection/built_collection.dart';
import 'package:flutter_dota_2_chatwheel/data/model/network/chatwheel_event.dart';
import 'package:flutter_dota_2_chatwheel/data/network/chatwheel_data_source.dart';

class ChatwheelRepository {
  final ChatwheelDataSource _chatwheelDataSource;

  ChatwheelRepository(this._chatwheelDataSource);

  // play song from internet
  // return BuiltList<ChatwheelEvent>
  Future<BuiltList<ChatwheelEvent?>> loadChatwheelEvents() async {
    final chatwheelEvents = await _chatwheelDataSource.getChatwheelEvents();

    if (chatwheelEvents.events.length == 0) throw EmptyResultException();

    return chatwheelEvents.events;
  }

  /// download all lines and make sure there wasn't duplicated lines
  /// store it to device storage
  /// get path of each downloaded lines
  /// all lines must be stored in database
  /// make sure no duplicated lines on database
  /// load data from database

}

class EmptyResultException implements Exception {
  final String message = 'No chatwheels found';
}
