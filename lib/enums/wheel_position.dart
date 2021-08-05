import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'wheel_position.g.dart';

class WheelPosition extends EnumClass {
  static const WheelPosition topLeft = _$topLeft;
  static const WheelPosition topCenter = _$topCenter;
  static const WheelPosition topRight = _$topRight;
  static const WheelPosition rightCenter = _$rightCenter;
  static const WheelPosition bottomRight = _$bottomRight;
  static const WheelPosition bottomCenter = _$bottomCenter;
  static const WheelPosition bottomLeft = _$bottomLeft;
  static const WheelPosition leftCenter = _$leftCenter;
  static const WheelPosition none = _$none;

  const WheelPosition._(String name) : super(name);

  static BuiltSet<WheelPosition> get values => _$values;
  static WheelPosition valueOf(String name) => _$valueOf(name);
}
