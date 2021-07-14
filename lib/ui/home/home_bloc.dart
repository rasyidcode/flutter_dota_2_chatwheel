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
    _chatwheelRepository.init();
    add(HomeInitiated());
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeInitiated) {
      yield HomeState.loading();

      try {
        // final events = await _chatwheelRepository.loadChatwheelEvents();
        final lines = await _chatwheelRepository.loadChatwheelLines(start: 0);
        // yield HomeState.success(lines);
        yield HomeState.success(lines);
      } on NoElementFoundException catch (e) {
        yield HomeState.failure(e.message);
      } on UnhandledException catch (e) {
        yield HomeState.failure(e.message);
      } on EmptyResultException catch (e) {
        yield HomeState.failure(e.message);
      } catch (e) {
        yield HomeState.failure('Something went wrong');
      }
    }
  }
}
