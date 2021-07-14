import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dota_2_chatwheel/data/network/chatwheel_data_source.dart';
import 'package:flutter_dota_2_chatwheel/data/repository/chatwheel_repository.dart';
import 'package:flutter_dota_2_chatwheel/extensions/element_extensions.dart';
import 'package:flutter_dota_2_chatwheel/ui/home/home_event.dart';
import 'package:flutter_dota_2_chatwheel/ui/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ChatwheelRepository _chatwheelRepository;

  HomeBloc(this._chatwheelRepository) : super(HomeState.initial());

  void onHomeInit() {
    add(HomeInitiated());
  }

  void fetchNextPage() {
    add(HomeNextPage());
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeInitiated) {
      yield* mapInitEvent();
    } else if (event is HomeNextPage) {
      yield* mapNextPageEvent();
    }
  }

  Stream<HomeState> mapInitEvent() async* {
    yield HomeState.loading();
    _chatwheelRepository.init();

    try {
      await _chatwheelRepository.storeChatwheels();

      final lines = await _chatwheelRepository.getLines();
      yield HomeState.success(lines);
    } on NoElementFoundException catch (e) {
      yield HomeState.failure(e.message);
    } on UnhandledException catch (e) {
      yield HomeState.failure(e.message);
    } on EmptyResultException catch (e) {
      yield HomeState.failure(e.message);
    }
  }

  Stream<HomeState> mapNextPageEvent() async* {
    try {
      final lines = await _chatwheelRepository.getLines();
      yield HomeState.success(state.lines + lines);
    } on EmptyResultException catch (_) {
      yield state.rebuild((b) => b..hasReachedEndOfResults = true);
    }
  }
}
