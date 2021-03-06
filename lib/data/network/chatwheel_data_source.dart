import 'dart:io';

import 'package:flutter_dota_2_chatwheel/data/model/network/chatwheel_event_result.dart';
import 'package:flutter_dota_2_chatwheel/data/scraper/chatwheel_scraper.dart';
import 'package:http/http.dart' as http;

const EVENT_CHATWHEEL_URL = 'https://dota2.fandom.com/wiki/Chat_Wheel';
const DOTA_PLUS_CHATWHEEL_URL =
    'https://dota2.fandom.com/wiki/Chat_Wheel/Dota_Plus';
const SUPPORTERS_CLUB_CHATWHEEL_URL =
    'https://dota2.fandom.com/wiki/Supporters_Club';

class ChatwheelDataSource {
  final http.Client _client;
  final ChatwheelScraper _scraper;

  ChatwheelDataSource(this._client, this._scraper);

  Future<ChatwheelEventResult> getChatwheelEvents() async {
    final chatwheelPageResponse = await _client.get(
      Uri.parse(EVENT_CHATWHEEL_URL),
      headers: {HttpHeaders.contentTypeHeader: 'text/html; charset=utf-8'},
    );

    if (chatwheelPageResponse.statusCode == 200) {
      final chatwheelEventResult =
          _scraper.getEvents(chatwheelPageResponse.body);
      return chatwheelEventResult;
    } else {
      throw UnhandledException();
    }
  }
}

class UnhandledException implements Exception {
  final String message = 'Something went wrong';
}
