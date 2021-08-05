import 'package:flutter_dota_2_chatwheel/enums/wheel_position.dart';

extension IntExtension on int {
  WheelPosition toWheelDotPosition() {
    switch (this) {
      case 0:
        return WheelPosition.topLeft;
      case 1:
        return WheelPosition.topCenter;
      case 2:
        return WheelPosition.topRight;
      case 3:
        return WheelPosition.rightCenter;
      case 4:
        return WheelPosition.bottomRight;
      case 5:
        return WheelPosition.bottomCenter;
      case 6:
        return WheelPosition.bottomLeft;
      case 7:
        return WheelPosition.leftCenter;
      default:
        return WheelPosition.none;
    }
  }
}
