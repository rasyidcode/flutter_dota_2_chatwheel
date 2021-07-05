library chatwheel_event;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter_dota_2_chatwheel/data/model/network/chatwheel_pack.dart';

part 'chatwheel_event.g.dart';

abstract class ChatwheelEvent
    implements Built<ChatwheelEvent, ChatwheelEventBuilder> {
  String get eventName;
  BuiltList<ChatwheelPack> get packs;

  ChatwheelEvent._();

  factory ChatwheelEvent([updates(ChatwheelEventBuilder b)]) = _$ChatwheelEvent;
}
