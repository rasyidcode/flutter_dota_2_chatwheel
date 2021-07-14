import 'package:flutter_dota_2_chatwheel/data/network/chatwheel_data_source.dart';
import 'package:flutter_dota_2_chatwheel/data/provider/chatwheel_line_provider.dart';
import 'package:flutter_dota_2_chatwheel/data/repository/chatwheel_repository.dart';
import 'package:flutter_dota_2_chatwheel/data/scraper/chatwheel_scraper.dart';
import 'package:flutter_dota_2_chatwheel/ui/home/home_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:http/http.dart' as http;

void initKiwi() {
  KiwiContainer()
    // Components
    ..registerInstance(http.Client())
    ..registerInstance(ChatwheelScraper())
    // Data Source
    ..registerFactory((c) => ChatwheelDataSource(c.resolve(), c.resolve()))
    // Provider
    ..registerFactory((c) => ChatwheelLineProvider())
    // Repository
    ..registerFactory((c) =>
        ChatwheelRepository(c.resolve(), c.resolve<ChatwheelLineProvider>()))
    // BloC
    ..registerFactory((c) => HomeBloc(c.resolve()));
}
