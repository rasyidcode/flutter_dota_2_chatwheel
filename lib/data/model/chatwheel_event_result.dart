library chatwheel_event_result;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_event.dart';
import 'package:flutter_dota_2_chatwheel/data/model/serializers.dart';

part 'chatwheel_event_result.g.dart';

abstract class ChatwheelEventResult
    implements Built<ChatwheelEventResult, ChatwheelEventResultBuilder> {
  BuiltList<ChatwheelEvent> get events;

  ChatwheelEventResult._();

  factory ChatwheelEventResult([updates(ChatwheelEventResultBuilder b)]) =
      _$ChatwheelEventResult;

  String toJson() {
    return json.encode(
        serializers.serializeWith(ChatwheelEventResult.serializer, this));
  }

  static ChatwheelEventResult? fromJson(String jsonString) {
    return serializers.deserializeWith(
        ChatwheelEventResult.serializer, json.decode(jsonString));
  }

  static Serializer<ChatwheelEventResult> get serializer =>
      _$chatwheelEventResultSerializer;
}
