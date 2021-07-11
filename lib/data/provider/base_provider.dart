import 'package:sqflite/sqflite.dart';

abstract class BaseProvider {
  Database _db;

  BaseProvider(this._db);

  close() {
    _db.close();
  }
}
