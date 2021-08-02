import 'package:built_collection/built_collection.dart';
import 'package:flutter_dota_2_chatwheel/data/model/local/chatwheel_line.dart';
import 'package:flutter_dota_2_chatwheel/data/provider/base_provider.dart';

class ChatwheelLineProvider extends BaseProvider {
  final String _tableName = 'chatwheel_lines';
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

  Future<bool> updateLine(int id, String localPath) async {
    final updateRes = await db?.rawUpdate(
        'UPDATE $_tableName SET localPath = ? WHERE id = ?', [localPath, id]);
    if (updateRes != null)
      return updateRes > 0;
    else
      return false;
  }

  Future<BuiltList<ChatwheelLine>?> getLines(int offset, int limit) async {
    final List<Map>? mapLines =
        await db?.rawQuery('SELECT * FROM $_tableName LIMIT $offset,$limit');
    if (mapLines != null) {
      return mapLines
          .map((line) => ChatwheelLine((b) => b
            ..id = line['id']
            ..eventName = line['eventName']
            ..packName = line['packName']
            ..line = line['line']
            ..lineTranslate = line['lineTranslate']
            ..url = line['url']
            ..localPath = line['localPath']
            ..createdAt = line['createdAt']
            ..updatedAt = line['updatedAt']))
          .toBuiltList();
    } else {
      return null;
    }
  }

  Future<List<Map<String, Object?>>?> countAllLines() async {
    return await db?.rawQuery('SELECT COUNT(*) as total FROM $_tableName');
  }
}