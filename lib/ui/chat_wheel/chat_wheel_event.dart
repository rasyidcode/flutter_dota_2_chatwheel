library home_event;

import 'package:built_value/built_value.dart';

part 'chat_wheel_event.g.dart';

abstract class ChatWheelEvent {}

abstract class ChatWheelInitiated extends ChatWheelEvent
    implements Built<ChatWheelInitiated, ChatWheelInitiatedBuilder> {
  ChatWheelInitiated._();

  factory ChatWheelInitiated([updates(ChatWheelInitiatedBuilder b)]) =
      _$ChatWheelInitiated;
}

class ChatWheelNextPage extends ChatWheelEvent {}

class ChatWheelDownload extends ChatWheelEvent {}
