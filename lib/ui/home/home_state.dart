library home_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter_dota_2_chatwheel/data/model/local/chatwheel_line.dart';

part 'home_state.g.dart';

abstract class HomeState implements Built<HomeState, HomeStateBuilder> {
  bool get isLoading;
  String get error;
  BuiltList<ChatwheelLine> get lines;
  bool get hasReachedEndOfResults;
  double get downloadProgress;

  bool get isSuccessful => !isLoading && lines.isNotEmpty && error == '';

  bool get isDownloading => downloadProgress > 0.0;

  bool get isDownloaded => downloadProgress == 100.0;

  HomeState._();

  factory HomeState([updates(HomeStateBuilder b)]) = _$HomeState;

  factory HomeState.initial() {
    return HomeState((b) => b
      ..isLoading = false
      ..lines.replace(BuiltList<ChatwheelLine>())
      ..error = ''
      ..hasReachedEndOfResults = false
      ..downloadProgress = 0.0);
  }

  factory HomeState.loading() {
    return HomeState((b) => b
      ..isLoading = true
      ..lines.replace(BuiltList<ChatwheelLine>())
      ..error = ''
      ..hasReachedEndOfResults = false
      ..downloadProgress = 0.0);
  }

  factory HomeState.failure(String error) {
    return HomeState((b) => b
      ..isLoading = false
      ..lines.replace(BuiltList<ChatwheelLine>())
      ..error = error
      ..hasReachedEndOfResults = false
      ..downloadProgress = 0.0);
  }

  factory HomeState.success(BuiltList<ChatwheelLine> events) {
    return HomeState((b) => b
      ..isLoading = false
      ..lines.replace(events)
      ..error = ''
      ..hasReachedEndOfResults = false
      ..downloadProgress = 0.0);
  }

  factory HomeState.downloading(double progress) {
    return HomeState((b) => b
      ..isLoading = false
      ..lines.replace(BuiltList<ChatwheelLine>())
      ..error = ''
      ..hasReachedEndOfResults = false
      ..downloadProgress = progress);
  }
}
