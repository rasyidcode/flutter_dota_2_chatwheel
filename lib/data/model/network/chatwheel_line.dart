library chatwheel_line;

import 'package:built_value/built_value.dart';
part 'chatwheel_line.g.dart';

abstract class ChatwheelLine
    implements Built<ChatwheelLine, ChatwheelLineBuilder> {
  String get line;
  String? get lineTranslate;
  String get url;

  ChatwheelLine._();

  factory ChatwheelLine([updates(ChatwheelLineBuilder b)]) = _$ChatwheelLine;
}
