library wheel_event;

import 'package:built_value/built_value.dart';

part 'wheel_event.g.dart';

abstract class WheelEvent {}

abstract class WheelInitiated extends WheelEvent
    implements Built<WheelInitiated, WheelInitiatedBuilder> {
  WheelInitiated._();

  factory WheelInitiated([updates(WheelInitiatedBuilder b)]) = _$WheelInitiated;
}
