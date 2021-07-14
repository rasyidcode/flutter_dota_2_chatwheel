import 'package:flutter/rendering.dart';
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
  final databasePath = await getDatabasesPath();
  final String path = join(databasePath, 'flutter_dota_2_chatwheel.db');

  KiwiContainer()
    // Components
    ..registerInstance(http.Client())
    ..registerInstance(ChatwheelScraper())
    ..registerInstance(await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table if not exists chatwheel_lines (
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
    // Data Source
    ..registerFactory<ChatwheelDataSource>(
        (c) => ChatwheelDataSource(c.resolve(), c.resolve()))
    // Provider
    ..registerFactory<ChatwheelLineProvider>(
        (c) => ChatwheelLineProvider(c.resolve()))
    // Repository
    ..registerFactory<ChatwheelRepository>((c) =>
        ChatwheelRepository(c.resolve(), c.resolve<ChatwheelLineProvider>()))
    // BloC
    ..registerFactory((c) => HomeBloc(c.resolve()));
}
