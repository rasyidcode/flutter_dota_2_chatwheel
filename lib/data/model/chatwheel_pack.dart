library chatwheel_pack;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_line.dart';
import 'package:flutter_dota_2_chatwheel/data/model/serializers.dart';

part 'chatwheel_pack.g.dart';

abstract class ChatwheelPack
    implements Built<ChatwheelPack, ChatwheelPackBuilder> {
  String get packName;
  int get bpLevel;
  BuiltList<ChatwheelLine> get lines;

  ChatwheelPack._();

  factory ChatwheelPack([updates(ChatwheelPackBuilder b)]) = _$ChatwheelPack;

  String toJson() {
    return json
        .encode(serializers.serializeWith(ChatwheelPack.serializer, this));
  }

  static ChatwheelPack? fromJson(String jsonString) {
    return serializers.deserializeWith(
        ChatwheelPack.serializer, json.decode(jsonString));
  }

  static Serializer<ChatwheelPack> get serializer => _$chatwheelPackSerializer;
}
