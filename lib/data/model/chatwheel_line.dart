library chatwheel_line;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_dota_2_chatwheel/data/model/serializers.dart';

part 'chatwheel_line.g.dart';

abstract class ChatwheelLine
    implements Built<ChatwheelLine, ChatwheelLineBuilder> {
  String get line;
  String? get lineTranslate;
  String get url;

  ChatwheelLine._();

  factory ChatwheelLine([updates(ChatwheelLineBuilder b)]) = _$ChatwheelLine;

  String toJson() {
    return json
        .encode(serializers.serializeWith(ChatwheelLine.serializer, this));
  }

  static ChatwheelLine? fromJson(String jsonString) {
    return serializers.deserializeWith(
        ChatwheelLine.serializer, json.decode(jsonString));
  }

  static Serializer<ChatwheelLine> get serializer => _$chatwheelLineSerializer;
}
