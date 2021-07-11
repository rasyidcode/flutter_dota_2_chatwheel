import 'package:flutter_dota_2_chatwheel/data/model/network/chatwheel_event_result.dart';
import 'package:flutter_dota_2_chatwheel/data/network/chatwheel_data_source.dart';
import 'package:flutter_dota_2_chatwheel/data/provider/chatwheel_line_provider.dart';
import 'package:flutter_dota_2_chatwheel/data/repository/chatwheel_repository.dart';
import 'package:flutter_dota_2_chatwheel/data/scraper/chatwheel_scraper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

import '../../helper/common_helper.dart';
import 'chatwheel_repository_test.mocks.dart';

@GenerateMocks(const [ChatwheelDataSource, ChatwheelLineProvider])
void main() {
  late MockChatwheelDataSource _dataSource;
  late ChatwheelLineProvider _provider;
  late ChatwheelRepository _repository;
  late ChatwheelEventResult _chatwheelEventResult;
  late ChatwheelScraper _scraper;

  setUp(() async {
    _dataSource = MockChatwheelDataSource();
    _provider = ChatwheelLineProvider(
        await openDatabase('test/data/fixtures/chatwheel_lines.db'));
    _repository = ChatwheelRepository(_dataSource, _provider);

    String sampleDocumentString =
        fixtures('chatwheel_scraper/getEvents', 'chatwheel_fullpage');
    _scraper = ChatwheelScraper();
    _chatwheelEventResult = _scraper.getEvents(sampleDocumentString);
  });

  group('test loadChatwheelEvents()', () {
    test('returns BuiltList<ChatwheelEvent> on success', () async {
      when(_dataSource.getChatwheelEvents())
          .thenAnswer((_) async => _chatwheelEventResult);

      final listEvent = await _repository.loadChatwheelEvents();
      expect(listEvent, _chatwheelEventResult.events);
    });

    test('returns EmptyResultException if no events found', () {});
  });
}
