import 'package:flutter_dota_2_chatwheel/data/network/chatwheel_data_source.dart';
import 'package:flutter_dota_2_chatwheel/data/provider/chatwheel_line_provider.dart';
import 'package:flutter_dota_2_chatwheel/data/repository/chatwheel_repository.dart';
import 'package:flutter_dota_2_chatwheel/data/scraper/chatwheel_scraper.dart';
import 'package:flutter_dota_2_chatwheel/ui/home/home_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void initKiwi() async {
  final String dbPath =
      join(await getDatabasesPath(), 'flutter_dota_2_chatwheel.db');
  KiwiContainer()
    ..registerInstance(http.Client())
    ..registerInstance(ChatwheelScraper())
    ..registerInstance(await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table chatwheel_lines (
        id integer primary key autoincrement,
        eventName text null,
        packName text null,
        line text null,
        lineTranslate text null,
        url text null,
        localPath text null,
        createdAt integer,
        updatedAt integer
      )
      ''');
    }))
    ..registerFactory<ChatwheelDataSource>(
        (c) => ChatwheelDataSource(c.resolve(), c.resolve()))
    ..registerFactory<ChatwheelLineProvider>(
        (c) => ChatwheelLineProvider(c.resolve()))
    ..registerFactory<ChatwheelRepository>((c) =>
        ChatwheelRepository(c.resolve(), c.resolve<ChatwheelLineProvider>()))
    ..registerFactory<HomeBloc>((c) => HomeBloc(c.resolve()));
}
