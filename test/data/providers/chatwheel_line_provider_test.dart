import 'package:built_collection/built_collection.dart';
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

  group('ChatwheelLineProvider test', () {
    test('insertBatch()', () async {
      List<Object?>? results =
          await _provider.insertBatch(testDataLines, returnResult: true);

      expect(results, TypeMatcher<List<Object?>?>());
      expect(results?.length, 12);
    });

    test('getLines()', () async {
      BuiltList<ChatwheelLine> results = await _provider.getLines(10, 2);

      expect(results, TypeMatcher<BuiltList<ChatwheelLine>>());
      expect(results.length, 2);
    });

    test('countAllLines()', () async {
      final result = await _provider.countAllLines();
      // print(result);
      expect(result, TypeMatcher<List<Map>>());
      expect(result[0]['total'], 12);
    });
  });
}
