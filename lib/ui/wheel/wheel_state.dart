library wheel_state;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter_dota_2_chatwheel/data/model/local/chatwheel_line.dart';

part 'wheel_state.g.dart';

abstract class WheelState implements Built<WheelState, WheelStateBuilder> {
  bool get isLoading;
  String get error;
  BuiltList<ChatwheelLine> get lines;

  WheelState._();

  factory WheelState([updates(WheelStateBuilder b)]) = _$WheelState;

  factory WheelState.initial() {
    return WheelState((b) => b
      ..isLoading = false
      ..lines.replace(BuiltList<ChatwheelLine>())
      ..error = '');
  }

  factory WheelState.loading() {
    return WheelState((b) => b
      ..isLoading = true
      ..lines.replace(BuiltList<ChatwheelLine>())
      ..error = '');
  }

  factory WheelState.error(String error) {
    return WheelState((b) => b
      ..isLoading = false
      ..lines.replace(BuiltList<ChatwheelLine>())
      ..error = error);
  }

  factory WheelState.success(BuiltList<ChatwheelLine> lines) {
    return WheelState((b) => b
      ..isLoading = false
      ..lines.replace(lines)
      ..error = '');
  }
}
