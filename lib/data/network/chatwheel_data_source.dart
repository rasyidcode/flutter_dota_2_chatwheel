import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_pack.dart';
import 'package:http/http.dart' as http;

const EVENT_CHATWHEEL_URL = 'https://dota2.fandom.com/wiki/Chat_Wheel';
const DOTA_PLUS_CHATWHEEL_URL =
    'https://dota2.fandom.com/wiki/Chat_Wheel/Dota_Plus';
const SUPPORTERS_CLUB_CHATWHEEL_URL =
    'https://dota2.fandom.com/wiki/Supporters_Club';

class ChatwheelDataSource {
  final http.Client _client;

  ChatwheelDataSource(this._client);

//   Future<List<Chatwheel>> getAllChatwheels() async {
//     final chatwheelPageResponse = await _client.get(Uri.parse(CHATWHEEL_URL));

//     if (chatwheelPageResponse.statusCode == 200) {
//       final chatwheelPageDocument = parse(chatwheelPageResponse.body);
//       final
//       return <Chatwheel>[];
//     } else {
//       throw UnhandledException();
//     }
//   }
// }

// class UnhandledException implements Exception {
//   final String message = 'Something went wrong';
// }
}
