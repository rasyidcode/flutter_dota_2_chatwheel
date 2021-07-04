import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_event.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_event_result.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_line.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_pack.dart';
import 'package:flutter_dota_2_chatwheel/data/scraper/chatwheel_scraper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

void main() {
  String fixtures(String name) =>
      File('test/data/fixtures/chatwheel_scraper/$name.html')
          .readAsStringSync();
  final chatwheelScraper = ChatwheelScraper();

  group('chatwheel_scraper.dart test', () {
    test('should return ChatwheelLine model and correct values', () {
      String sampleDocumentString = fixtures('the_correct_span');
      String sampleDocumentString2 = fixtures('the_correct_span2');

      final Document sampleDocument = parse(sampleDocumentString);
      final Document sampleDocument2 = parse(sampleDocumentString2);

      final Element? span = sampleDocument.querySelector('li > span > audio');
      final Element? span2 = sampleDocument2.querySelector('li > span > audio');

      final line = chatwheelScraper.getLine(span);
      final line2 = chatwheelScraper.getLine(span2);

      expect(line, TypeMatcher<ChatwheelLine>());
      expect(line.line, 'Ba-dum tishh');
      expect(line.lineTranslate, null);
      expect(line.url,
          'https://static.wikia.nocookie.net/dota2_gamepedia/images/f/fc/Misc_soundboard_rimshot.mp3/revision/latest?cb=20190922222137');

      expect(line2, TypeMatcher<ChatwheelLine>());
      expect(line2.line, 'Боже, ты посмотри вокруг, что происходит!');
      expect(line2.lineTranslate, 'God, look around at what is happening!');
      expect(line2.url,
          'https://static.wikia.nocookie.net/dota2_gamepedia/images/6/6a/Misc_soundboard_bozhe_ti_posmotri.mp3/revision/latest?cb=20190922222030');
    });

    test('should return ChatwheelPack model and correct values', () {
      String sampleDocumentString = fixtures('pack_element');
      String sampleDocumentString2 = fixtures('pack_element2');
      String sampleDocumentString3 = fixtures('pack_element3');
      String sampleDocumentString4 = fixtures('pack_element4');

      final Document sampleDocument = parse(sampleDocumentString);
      final Document sampleDocument2 = parse(sampleDocumentString2);
      final Document sampleDocument3 = parse(sampleDocumentString3);
      final Document sampleDocument4 = parse(sampleDocumentString4);

      final Element? tr = sampleDocument.querySelector('tr');
      final Element? tr2 = sampleDocument2.querySelector('tr');
      final Element? tr3 = sampleDocument3.querySelector('tr');
      final Element? tr4 = sampleDocument4.querySelector('tr');

      final packs = chatwheelScraper.getPack2(tr);
      final packs2 = chatwheelScraper.getPack2(tr2);
      final packs3 = chatwheelScraper.getPack2(tr3);
      final packs4 = chatwheelScraper.getPack2(tr4);

      expect(packs, TypeMatcher<ChatwheelPack>());
      expect(packs2, TypeMatcher<ChatwheelPack>());
      expect(packs3, TypeMatcher<ChatwheelPack>());
      expect(packs4, TypeMatcher<ChatwheelPack>());
    });

    test('should return either ChatwheelEvent or null value', () {
      String sampleDocumentString = fixtures('event_element');
      String sampleDocumentString2 = fixtures('event_element2');
      String sampleDocumentString3 = fixtures('event_element3');

      final Document sampleDocument = parse(sampleDocumentString);
      final Document sampleDocument2 = parse(sampleDocumentString2);
      final Document sampleDocument3 = parse(sampleDocumentString3);

      final Element? table = sampleDocument.querySelector('table');
      final Element? table2 = sampleDocument2.querySelector('table');
      final Element? table3 = sampleDocument3.querySelector('table');

      final event = chatwheelScraper.getEvent2(table);
      final event2 = chatwheelScraper.getEvent2(table2);
      final event3 = chatwheelScraper.getEvent2(table3);

      expect(event, TypeMatcher<ChatwheelEvent>());
      expect(event2, TypeMatcher<ChatwheelEvent>());
      expect(event3, null);
    });

    test('should return a ChatwheelEventResult', () {
      String sampleDocumentString = fixtures('chatwheel_fullpage2');
      final events = chatwheelScraper.getEvents2(sampleDocumentString);
      expect(events, TypeMatcher<ChatwheelEventResult>());
    });
  });
}
