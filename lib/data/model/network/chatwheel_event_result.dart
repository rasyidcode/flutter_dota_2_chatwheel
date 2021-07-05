library chatwheel_event_result;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter_dota_2_chatwheel/data/model/network/chatwheel_event.dart';

part 'chatwheel_event_result.g.dart';

abstract class ChatwheelEventResult
    implements Built<ChatwheelEventResult, ChatwheelEventResultBuilder> {
  BuiltList<ChatwheelEvent?> get events;

  ChatwheelEventResult._();

  factory ChatwheelEventResult([updates(ChatwheelEventResultBuilder b)]) =
      _$ChatwheelEventResult;
}
