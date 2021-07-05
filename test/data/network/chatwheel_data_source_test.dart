import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_event.dart';
import 'package:flutter_dota_2_chatwheel/data/network/chatwheel_data_source.dart';
import 'package:flutter_dota_2_chatwheel/data/scraper/chatwheel_scraper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import '../../helper/common_helper.dart';

import 'chatwheel_data_source_test.mocks.dart';

@GenerateMocks([http.Client, ChatwheelScraper])
void main() {
  final chatwheelScraper = ChatwheelScraper();
  late MockClient _client;
  late MockChatwheelScraper _scraper;
  late ChatwheelDataSource _chatwheelDataSouce;

  setUp(() {
    _client = MockClient();
    _scraper = MockChatwheelScraper();
    _chatwheelDataSouce = ChatwheelDataSource(_client, _scraper);
  });

  group('getChatwheelEvents()', () {
    test('must return BuiltList<ChatwheelEvent>', () async {
      when(_client.get(
        Uri.parse(EVENT_CHATWHEEL_URL),
        headers: anyNamed('headers'),
      )).thenAnswer(
        (_) async => http.Response(
          fixtures('chatwheel_scraper/getEvents', 'chatwheel_fullpage'),
          200,
          headers: {HttpHeaders.contentTypeHeader: 'text/html; charset=utf-8'},
        ),
      );

      String sampleDocumentString =
          fixtures('chatwheel_scraper/getEvents', 'chatwheel_fullpage');
      final eventsScraper = chatwheelScraper.getEvents(sampleDocumentString);

      when(_scraper.getEvents(any)).thenReturn(eventsScraper);

      final events = await _chatwheelDataSouce.getChatwheelEvents();

      expect(events, TypeMatcher<BuiltList<ChatwheelEvent?>>());
    });
  });
}
