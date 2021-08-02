library home_event;

import 'package:built_value/built_value.dart';

part 'home_event.g.dart';

abstract class HomeEvent {}

abstract class HomeInitiated extends HomeEvent
    implements Built<HomeInitiated, HomeInitiatedBuilder> {
  HomeInitiated._();

  factory HomeInitiated([updates(HomeInitiatedBuilder b)]) = _$HomeInitiated;
}

class HomeNextPage extends HomeEvent {}

class HomeDownload extends HomeEvent {}
