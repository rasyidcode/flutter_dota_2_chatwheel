library home_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter_dota_2_chatwheel/data/model/network/chatwheel_event.dart';

part 'home_state.g.dart';

abstract class HomeState implements Built<HomeState, HomeStateBuilder> {
  bool get isLoading;
  String get error;
  BuiltList<ChatwheelEvent?> get events;

  bool get isSuccessful => !isLoading && events.isNotEmpty && error == '';

  HomeState._();

  factory HomeState([updates(HomeStateBuilder b)]) = _$HomeState;

  factory HomeState.initial() {
    return HomeState((b) => b
      ..isLoading = false
      ..events.replace(BuiltList<ChatwheelEvent?>())
      ..error = '');
  }

  factory HomeState.loading() {
    return HomeState((b) => b
      ..isLoading = true
      ..events.replace(BuiltList<ChatwheelEvent?>())
      ..error = '');
  }

  factory HomeState.failure(String error) {
    return HomeState((b) => b
      ..isLoading = false
      ..events.replace(BuiltList<ChatwheelEvent?>())
      ..error = error);
  }

  factory HomeState.success(BuiltList<ChatwheelEvent?> events) {
    return HomeState((b) => b
      ..isLoading = false
      ..events.replace(events)
      ..error = '');
  }
}
