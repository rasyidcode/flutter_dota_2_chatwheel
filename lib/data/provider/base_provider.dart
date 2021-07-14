import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class BaseProvider {
  late Database db;

  Future<Null> open() async {
    final databasePath = await getDatabasesPath();
    final String path = join(databasePath, 'flutter_dota_2_chatwheel.db');
    db = await openDatabase(path, version: 1,
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
    });
  }

  void close() {
    db.close();
  }
}
