library home_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter_dota_2_chatwheel/data/model/local/chatwheel_line.dart';

part 'chat_wheel_state.g.dart';

abstract class ChatWheelState
    implements Built<ChatWheelState, ChatWheelStateBuilder> {
  bool get isLoading;
  String get error;
  BuiltList<ChatwheelLine> get lines;
  bool get hasReachedEndOfResults;
  bool get isDownloading;
  bool get isDownloaded;
  bool get isFailDownload;
  int? get downloadingId;

  bool get isSuccessful => !isLoading && lines.isNotEmpty && error == '';

  ChatWheelState._();

  factory ChatWheelState([updates(ChatWheelStateBuilder b)]) = _$ChatWheelState;

  factory ChatWheelState.initial() {
    return ChatWheelState((b) => b
      ..isLoading = false
      ..lines.replace(BuiltList<ChatwheelLine>())
      ..error = ''
      ..hasReachedEndOfResults = false
      ..isDownloading = false
      ..isDownloaded = false
      ..isFailDownload = false);
  }

  factory ChatWheelState.loading() {
    return ChatWheelState((b) => b
      ..isLoading = true
      ..lines.replace(BuiltList<ChatwheelLine>())
      ..error = ''
      ..hasReachedEndOfResults = false
      ..isDownloading = false
      ..isDownloaded = false
      ..isFailDownload = false);
  }

  factory ChatWheelState.failure(String error) {
    return ChatWheelState((b) => b
      ..isLoading = false
      ..lines.replace(BuiltList<ChatwheelLine>())
      ..error = error
      ..hasReachedEndOfResults = false
      ..isDownloading = false
      ..isDownloaded = false
      ..isFailDownload = false);
  }

  factory ChatWheelState.success(BuiltList<ChatwheelLine> lines) {
    return ChatWheelState((b) => b
      ..isLoading = false
      ..lines.replace(lines)
      ..error = ''
      ..hasReachedEndOfResults = false
      ..isDownloading = false
      ..isDownloaded = false
      ..isFailDownload = false);
  }

  factory ChatWheelState.downloading(BuiltList<ChatwheelLine> lines, int? dId) {
    return ChatWheelState((b) => b
      ..isLoading = false
      ..lines.replace(lines)
      ..error = ''
      ..hasReachedEndOfResults = false
      ..isDownloading = true
      ..isDownloaded = false
      ..isFailDownload = false
      ..downloadingId = dId);
  }

  factory ChatWheelState.downloaded(BuiltList<ChatwheelLine> lines, int? dId) {
    return ChatWheelState((b) => b
      ..isLoading = false
      ..lines.replace(lines)
      ..error = ''
      ..hasReachedEndOfResults = false
      ..isDownloading = false
      ..isDownloaded = true
      ..isFailDownload = false
      ..downloadingId = dId);
  }

  factory ChatWheelState.downloadFail(
      BuiltList<ChatwheelLine> lines, int? dId) {
    return ChatWheelState((b) => b
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
