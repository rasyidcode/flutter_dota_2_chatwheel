library chatwheel_line;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_dota_2_chatwheel/data/model/serializers/serializers.dart';
import 'package:flutter_dota_2_chatwheel/enums/chat_wheel_dot_position.dart';

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
  ChatWheelDotPosition get wheelPosition;

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
      'wheelIndex': _getWheelIndex(wheelPosition),
      'updatedAt': updatedAt,
    };
    return map;
  }

  static Serializer<ChatwheelLine> get serializer => _$chatwheelLineSerializer;

  int _getWheelIndex(ChatWheelDotPosition chatWheelPosition) {
    switch (chatWheelPosition) {
      case ChatWheelDotPosition.topLeft:
        return 0;
      case ChatWheelDotPosition.topCenter:
        return 1;
      case ChatWheelDotPosition.topRight:
        return 2;
      case ChatWheelDotPosition.rightCenter:
        return 3;
      case ChatWheelDotPosition.bottomRight:
        return 4;
      case ChatWheelDotPosition.bottomCenter:
        return 5;
      case ChatWheelDotPosition.bottomLeft:
        return 6;
      case ChatWheelDotPosition.leftCenter:
        return 7;
      default:
        return -1;
    }
  }
}
