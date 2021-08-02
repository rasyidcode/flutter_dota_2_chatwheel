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
  bool get isDownloading;
  bool get isDownloaded;
  bool get isFailDownload;
  int? get downloadingId;

  bool get isSuccessful => !isLoading && lines.isNotEmpty && error == '';

  HomeState._();

  factory HomeState([updates(HomeStateBuilder b)]) = _$HomeState;

  factory HomeState.initial() {
    return HomeState((b) => b
      ..isLoading = false
      ..lines.replace(BuiltList<ChatwheelLine>())
      ..error = ''
      ..hasReachedEndOfResults = false
      ..isDownloading = false
      ..isDownloaded = false
      ..isFailDownload = false);
  }

  factory HomeState.loading() {
    return HomeState((b) => b
      ..isLoading = true
      ..lines.replace(BuiltList<ChatwheelLine>())
      ..error = ''
      ..hasReachedEndOfResults = false
      ..isDownloading = false
      ..isDownloaded = false
      ..isFailDownload = false);
  }

  factory HomeState.failure(String error) {
    return HomeState((b) => b
      ..isLoading = false
      ..lines.replace(BuiltList<ChatwheelLine>())
      ..error = error
      ..hasReachedEndOfResults = false
      ..isDownloading = false
      ..isDownloaded = false
      ..isFailDownload = false);
  }

  factory HomeState.success(BuiltList<ChatwheelLine> lines) {
    return HomeState((b) => b
      ..isLoading = false
      ..lines.replace(lines)
      ..error = ''
      ..hasReachedEndOfResults = false
      ..isDownloading = false
      ..isDownloaded = false
      ..isFailDownload = false);
  }

  factory HomeState.downloading(BuiltList<ChatwheelLine> lines, int? dId) {
    return HomeState((b) => b
      ..isLoading = false
      ..lines.replace(lines)
      ..error = ''
      ..hasReachedEndOfResults = false
      ..isDownloading = true
      ..isDownloaded = false
      ..isFailDownload = false
      ..downloadingId = dId);
  }

  factory HomeState.downloaded(BuiltList<ChatwheelLine> lines, int? dId) {
    return HomeState((b) => b
      ..isLoading = false
      ..lines.replace(lines)
      ..error = ''
      ..hasReachedEndOfResults = false
      ..isDownloading = false
      ..isDownloaded = true
      ..isFailDownload = false
      ..downloadingId = dId);
  }

  factory HomeState.downloadFail(BuiltList<ChatwheelLine> lines, int? dId) {
    return HomeState((b) => b
      ..isLoading = false
      ..lines.replace(lines)
      ..error = ''
      ..hasReachedEndOfResults = false
      ..isDownloading = false
      ..isDownloaded = false
      ..isFailDownload = true
      ..downloadingId = dId);
  }
}
