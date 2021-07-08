import 'package:flutter_dota_2_chatwheel/data/network/chatwheel_data_source.dart';
import 'package:flutter_dota_2_chatwheel/data/repository/chatwheel_repository.dart';
import 'package:flutter_dota_2_chatwheel/data/scraper/chatwheel_scraper.dart';
import 'package:flutter_dota_2_chatwheel/ui/home/home_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:http/http.dart' as http;

void initKiwi() {
  KiwiContainer()
    ..registerInstance(http.Client())
    ..registerInstance(ChatwheelScraper())
    ..registerFactory((container) =>
        ChatwheelDataSource(container.resolve(), container.resolve()))
    ..registerFactory((container) => ChatwheelRepository(container.resolve()))
    ..registerFactory((container) => HomeBloc(container.resolve()));
}
