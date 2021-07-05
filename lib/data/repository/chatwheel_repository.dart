import 'package:flutter_dota_2_chatwheel/data/network/chatwheel_data_source.dart';

class ChatwheelRepository {
  final ChatwheelDataSource _chatwheelDataSource;

  ChatwheelRepository(this._chatwheelDataSource);

  /// download all lines and make sure there wasn't duplicated lines
  /// store it to device storage
  /// get path of each downloaded lines
  /// all lines must be stored in database
  /// make sure no duplicated lines on database
  /// load data from database

}
