import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'chat_wheel_dot_position.g.dart';

class ChatWheelDotPosition extends EnumClass {
  static const ChatWheelDotPosition topLeft = _$topLeft;
  static const ChatWheelDotPosition topCenter = _$topCenter;
  static const ChatWheelDotPosition topRight = _$topRight;
  static const ChatWheelDotPosition rightCenter = _$rightCenter;
  static const ChatWheelDotPosition bottomRight = _$bottomRight;
  static const ChatWheelDotPosition bottomCenter = _$bottomCenter;
  static const ChatWheelDotPosition bottomLeft = _$bottomLeft;
  static const ChatWheelDotPosition leftCenter = _$leftCenter;
  static const ChatWheelDotPosition none = _$none;

  const ChatWheelDotPosition._(String name) : super(name);

  static BuiltSet<ChatWheelDotPosition> get values => _$values;
  static ChatWheelDotPosition valueOf(String name) => _$valueOf(name);
}
