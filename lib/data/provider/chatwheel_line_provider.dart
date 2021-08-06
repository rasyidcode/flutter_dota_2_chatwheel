import 'package:built_collection/built_collection.dart';
import 'package:flutter_dota_2_chatwheel/data/model/local/chatwheel_line.dart';
import 'package:flutter_dota_2_chatwheel/data/provider/base_provider.dart';
import 'package:flutter_dota_2_chatwheel/enums/wheel_position.dart';
import 'package:flutter_dota_2_chatwheel/extensions/int_extensions.dart';
import 'package:flutter_dota_2_chatwheel/extensions/wheel_position_extensions.dart';

class ChatwheelLineProvider extends BaseProvider {
  final String _tableName = 'chatwheel_lines';

  //--------------------- get part ---------------------//
  /// Get lines paginated
  Future<BuiltList<ChatwheelLine>?> getLines(int offset, int limit) async {
    final List<Map>? mapLines =
        await db?.rawQuery('SELECT * FROM $_tableName LIMIT $offset,$limit');
    if (mapLines != null) {
      return mapLines
          .map(
            (line) => ChatwheelLine(
              (b) => b
                ..id = (line['id'] as int)
                ..eventName = (line['eventName'] as String)
                ..packName = (line['packName'] as String)
                ..line = (line['line'] as String)
                ..lineTranslate = (line['lineTranslate'] as String)
                ..url = (line['url'] as String)
                ..showInWheel = (line['showInWheel'] as int) == 1 ? true : false
                ..wheelPos = (line['wheelPos'] as int).toWheelDotPosition()
                ..localPath = (line['localPath'] as String)
                ..createdAt = (line['createdAt'] as int)
                ..updatedAt = (line['updatedAt'] as int),
            ),
          )
          .toBuiltList();
    } else {
      return null;
    }
  }

  /// Get lines where showInLines is true
  Future<BuiltList<ChatwheelLine>?> getShowInWheelLines() async {
    final List<Map>? wheelLines =
        await db?.rawQuery('SELECT * FROM $_tableName WHERE showInWheel = 1');
    if (wheelLines != null) {
      return wheelLines
          .map(
            (line) => ChatwheelLine(
              (b) => b
                ..id = (line['id'] as int)
                ..eventName = (line['eventName'] as String)
                ..packName = (line['packName'] as String)
                ..line = (line['line'] as String)
                ..lineTranslate = (line['lineTranslate'] as String)
                ..url = (line['url'] as String)
                ..showInWheel = (line['showInWheel'] as int) == 1 ? true : false
                ..localPath = (line['localPath'] as String)
                ..wheelPos = (line['wheelPos'] as int).toWheelDotPosition()
                ..createdAt = (line['createdAt'] as int)
                ..updatedAt = (line['updatedAt'] as int),
            ),
          )
          .toBuiltList();
    } else {
      return null;
    }
  }

  /// Count all lines on database
  Future<List<Map<String, Object?>>?> countAllLines() async {
    return await db?.rawQuery('SELECT COUNT(*) as total FROM $_tableName');
  }

  /// Get single line
  Future<ChatwheelLine?> getLine(int id) async {
    final lines =
        await db?.rawQuery('SELECT * FROM $_tableName WHERE id = $id');
    if (lines != null) {
      final lineList = lines
          .map(
            (line) => ChatwheelLine(
              (b) => b
                ..id = (line['id'] as int)
                ..eventName = (line['eventName'] as String)
                ..packName = (line['packName'] as String)
                ..line = (line['line'] as String)
                ..lineTranslate = (line['lineTranslate'] as String)
                ..url = (line['url'] as String)
                ..showInWheel = (line['showInWheel'] as int) == 1 ? true : false
                ..localPath = (line['localPath'] as String)
                ..wheelPos = (line['wheelPos'] as int).toWheelDotPosition()
                ..createdAt = (line['createdAt'] as int)
                ..updatedAt = (line['updatedAt'] as int),
            ),
          )
          .toBuiltList();
      return lineList[0];
    } else {
      return null;
    }
  }

  //--------------------- insert part ---------------------//
  /// Insert all chat wheel at once to database
  Future<List<Object?>?> insertBatch(List<ChatwheelLine> lines,
      {returnResult: false}) async {
    final batch = db?.batch();
    lines.forEach((line) {
      batch?.insert(_tableName, line.toMap());
    });
    if (!returnResult) {
      await batch?.commit(noResult: true);
    } else {
      return batch?.commit();
    }
  }

  //--------------------- update part ---------------------//
  /// Modify line's showInWheel
  Future<bool> updateLineShowInWheel({
    required bool showInWheel,
    required WheelPosition wheelPosition,
    required int id,
  }) async {
    final int? _count = await db?.rawUpdate(
        'UPDATE $_tableName SET showInWheel = ?, wheelPos = ? WHERE id = ?',
        [showInWheel ? 1 : 0, wheelPosition.toWheelDotIndex(), id]);
    if (_count != null) {
      return _count > 0;
    } else
      return false;
  }

  /// Modify line's localPath
  Future<bool> updateLineLocalPath(int id, String localPath) async {
    final updateRes = await db?.rawUpdate(
        'UPDATE $_tableName SET localPath = ? WHERE id = ?', [localPath, id]);
    if (updateRes != null)
      return updateRes > 0;
    else
      return false;
  }

  //--------------------- delete part ---------------------//

  //--------------------- private method part -------------//
}
