library chatwheel_pack;

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_dota_2_chatwheel/data/model/network/chatwheel_line.dart';

part 'chatwheel_pack.g.dart';

abstract class ChatwheelPack
    implements Built<ChatwheelPack, ChatwheelPackBuilder> {
  String get packName;
  int get bpLevel;
  BuiltList<ChatwheelLine> get lines;

  ChatwheelPack._();

  factory ChatwheelPack([updates(ChatwheelPackBuilder b)]) = _$ChatwheelPack;
}
