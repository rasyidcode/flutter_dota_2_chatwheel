import 'package:built_collection/built_collection.dart';
import 'package:flutter_dota_2_chatwheel/data/model/local/chatwheel_line.dart';
import 'package:flutter_dota_2_chatwheel/data/provider/base_provider.dart';
import 'package:flutter_dota_2_chatwheel/enums/chat_wheel_dot_position.dart';

class ChatwheelLineProvider extends BaseProvider {
  final String _tableName = 'chatwheel_lines';

  //--------------------- get part ---------------------//
  /// Get lines paginated
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
            ..showInWheel = line['showInWheel'] == 1 ? true : false
            ..wheelPosition = _getWheelPosition(line['wheelLine'])
            ..localPath = line['localPath']
            ..createdAt = line['createdAt']
            ..updatedAt = line['updatedAt']))
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
          .map((line) => ChatwheelLine((b) => b
            ..id = line['id']
            ..eventName = line['eventName']
            ..packName = line['packName']
            ..line = line['line']
            ..lineTranslate = line['lineTranslate']
            ..url = line['url']
            ..showInWheel = line['showInWheel'] == 1 ? true : false
            ..localPath = line['localPath']
            ..wheelPosition = _getWheelPosition(line['wheelLine'])
            ..createdAt = line['createdAt']
            ..updatedAt = line['updatedAt']))
          .toBuiltList();
    } else {
      return null;
    }
  }

  /// Count all lines on database
  Future<List<Map<String, Object?>>?> countAllLines() async {
    return await db?.rawQuery('SELECT COUNT(*) as total FROM $_tableName');
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
  Future<bool> updateLineShowInWheel(
      int id, bool showInWheel, ChatWheelDotPosition dotPosition) async {
    final updateRes = await db?.rawUpdate(
        'UPDATE $_tableName SET showInWheel = ? WHERE id = ? AND wheelIndex = ?',
        [showInWheel ? 1 : 0, id, dotPosition]);
    if (updateRes != null)
      return updateRes > 0;
    else
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
  ChatWheelDotPosition _getWheelPosition(int wheelIndex) {
    switch (wheelIndex) {
      case 0:
        return ChatWheelDotPosition.topLeft;
      case 1:
        return ChatWheelDotPosition.topCenter;
      case 2:
        return ChatWheelDotPosition.topRight;
      case 3:
        return ChatWheelDotPosition.rightCenter;
      case 4:
        return ChatWheelDotPosition.bottomRight;
      case 5:
        return ChatWheelDotPosition.bottomCenter;
      case 6:
        return ChatWheelDotPosition.bottomLeft;
      case 7:
        return ChatWheelDotPosition.leftCenter;
      default:
        return ChatWheelDotPosition.none;
    }
  }
}
