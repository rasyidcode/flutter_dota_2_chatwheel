library chatwheel_line;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_dota_2_chatwheel/data/model/serializers/serializers.dart';
import 'package:flutter_dota_2_chatwheel/enums/wheel_position.dart';
import 'package:flutter_dota_2_chatwheel/extensions/wheel_position_extensions.dart';

part 'chatwheel_line.g.dart';

abstract class ChatwheelLine
    implements Built<ChatwheelLine, ChatwheelLineBuilder> {
  int? get id;
  String get eventName;
  String get packName;
  String get line;
  String get lineTranslate;
  String get url;
  String get localPath;
  int get createdAt;
  int get updatedAt;
  bool get showInWheel;
  WheelPosition get wheelPos;

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

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'eventName': eventName,
      'packName': packName,
      'line': line,
      'lineTranslate': lineTranslate,
      'url': url,
      'localPath': localPath,
      'createdAt': createdAt,
      'showInWheel': showInWheel ? 1 : 0,
      'wheelPos': wheelPos.toWheelDotIndex(),
      'updatedAt': updatedAt,
    };
    return map;
  }

  static Serializer<ChatwheelLine> get serializer => _$chatwheelLineSerializer;
}
