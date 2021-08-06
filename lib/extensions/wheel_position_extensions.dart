import 'package:flutter_dota_2_chatwheel/enums/wheel_position.dart';

extension WheelPositionExtensions on WheelPosition {
  int toWheelDotIndex() {
    switch (this) {
      case WheelPosition.topLeft:
        return 0;
      case WheelPosition.topCenter:
        return 1;
      case WheelPosition.topRight:
        return 2;
      case WheelPosition.rightCenter:
        return 3;
      case WheelPosition.bottomRight:
        return 4;
      case WheelPosition.bottomCenter:
        return 5;
      case WheelPosition.bottomLeft:
        return 6;
      case WheelPosition.leftCenter:
        return 7;
      default:
        return -1;
    }
  }
}
