import 'package:flutter_dota_2_chatwheel/data/model/local/chatwheel_line.dart';
import 'package:flutter_dota_2_chatwheel/data/provider/chatwheel_line_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  late Database _db;
  late ChatwheelLineProvider _provider;
  late List<ChatwheelLine> testDataLines;

  setUp(() async {
    _db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await _db.execute('''
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
    _provider = ChatwheelLineProvider(_db);
    testDataLines = [
      ChatwheelLine(
        (b) => b
          ..eventName = 'test1'
          ..packName = 'test1'
          ..line = 'test1'
          ..lineTranslate = 'test1'
          ..url = 'test1'
          ..localPath = 'test1'
          ..createdAt = 1
          ..updatedAt = 1,
      ),
      ChatwheelLine(
        (b) => b
          ..eventName = 'test2'
          ..packName = 'test2'
          ..line = 'test2'
          ..lineTranslate = 'test2'
          ..url = 'test3'
          ..localPath = 'test2'
          ..createdAt = 2
          ..updatedAt = 2,
      ),
      ChatwheelLine(
        (b) => b
          ..eventName = 'test3'
          ..packName = 'test3'
          ..line = 'test3'
          ..lineTranslate = 'test3'
          ..url = 'test3'
          ..localPath = 'test3'
          ..createdAt = 3
          ..updatedAt = 3,
      )
    ];
  });

  group('insertBatch()', () {
    test('insert list of ChatwheelLine', () async {
      List<Object?>? results =
          await _provider.insertBatch(testDataLines, returnResult: true);

      expect(results, TypeMatcher<List<Object?>?>());
      expect(results?.length, 3);
    });
  });
}
