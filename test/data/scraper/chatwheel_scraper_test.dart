import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_event.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_event_result.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_line.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_pack.dart';
import 'package:flutter_dota_2_chatwheel/data/scraper/chatwheel_scraper.dart';
import 'package:flutter_dota_2_chatwheel/extensions/element_extensions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import '../../helper/common_helper.dart';
import '../../constants/scraper/chatwheel_getLine.dart';

void main() {
  final chatwheelScraper = ChatwheelScraper();

  group('getLine() test', () {
    test('should return ChatwheelLine model with lineTranslate null', () {
      String sampleDocumentString = fixtures('chatwheel_scraper/getLine',
          'chatwheel_single_element_with_no_translate');

      final Document sampleDocument = parse(sampleDocumentString);
      final Element? audio = sampleDocument.querySelector('li > span > audio');
      final lineTestResult = chatwheelScraper.getLine(audio);

      expect(lineTestResult, TypeMatcher<ChatwheelLine>());
      expect(lineTestResult.line, lineData1.line);
      expect(lineTestResult.lineTranslate, lineData1.lineTranslate);
      expect(lineTestResult.url, lineData1.url);
    });

    test('should return ChatwheelLine model with lineTranslate not null', () {
      String sampleDocumentString = fixtures('chatwheel_scraper/getLine',
          'chatwheel_single_element_with_translate');
      final Document sampleDocument = parse(sampleDocumentString);
      final Element? audio = sampleDocument.querySelector('li > span > audio');
      final lineTestResult = chatwheelScraper.getLine(audio);

      expect(lineTestResult, TypeMatcher<ChatwheelLine>());
      expect(lineTestResult.line, lineData2.line);
      expect(lineTestResult.lineTranslate, lineData2.lineTranslate);
      expect(lineTestResult.url, lineData2.url);
    });

    test('throw NoElementFoundException with null element passed', () {
      String sampleDocumentString = fixtures('chatwheel_scraper/getLine',
          'chatwheel_single_element_with_no_audio');
      final Document sampleDocument = parse(sampleDocumentString);
      final Element? audio = sampleDocument.querySelector('li > span > audio');
      expect(() => chatwheelScraper.getLine(audio),
          throwsA(TypeMatcher<NoElementFoundException>()));
    });

    test('throw NoElementFoundException with not audio element passed', () {
      String sampleDocumentString = fixtures('chatwheel_scraper/getLine',
          'chatwheel_single_element_with_not_audio');
      final Document sampleDocument = parse(sampleDocumentString);
      final Element? audio = sampleDocument.querySelector('li > span > audio');
      expect(() => chatwheelScraper.getLine(audio),
          throwsA(TypeMatcher<NoElementFoundException>()));
    });

    test('throw NoElementFoundException with no src of audio element passed',
        () {
      String sampleDocumentString = fixtures(
          'chatwheel_scraper/getLine', 'chatwheel_single_element_with_no_src');
      final Document sampleDocument = parse(sampleDocumentString);
      final Element? audio = sampleDocument.querySelector('li > span > audio');
      final lineTestResult = chatwheelScraper.getLine(audio);

      expect(lineTestResult, TypeMatcher<ChatwheelLine>());
      expect(lineTestResult.line, lineData3.line);
      expect(lineTestResult.lineTranslate, lineData3.lineTranslate);
      expect(lineTestResult.url, lineData3.url);
    });

    test('throw NoElementFoundException with no line passed', () {
      String sampleDocumentString = fixtures(
          'chatwheel_scraper/getLine', 'chatwheel_single_element_with_no_line');
      final Document sampleDocument = parse(sampleDocumentString);
      final Element? audio = sampleDocument.querySelector('li > span > audio');
      final lineTestResult = chatwheelScraper.getLine(audio);

      expect(lineTestResult, TypeMatcher<ChatwheelLine>());
      expect(lineTestResult.line, lineData4.line);
      expect(lineTestResult.lineTranslate, lineData4.lineTranslate);
      expect(lineTestResult.url, lineData4.url);
    });
  });

  group('getPack()', () {
    test('should return ChatwheelPack model and correct values', () {
      String sampleDocumentString =
          fixtures('chatwheel_scraper', 'pack_element');
      String sampleDocumentString2 =
          fixtures('chatwheel_scraper', 'pack_element2');
      String sampleDocumentString3 =
          fixtures('chatwheel_scraper', 'pack_element3');
      String sampleDocumentString4 =
          fixtures('chatwheel_scraper', 'pack_element4');

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
      String sampleDocumentString =
          fixtures('chatwheel_scraper', 'event_element');
      String sampleDocumentString2 =
          fixtures('chatwheel_scraper', 'event_element2');
      String sampleDocumentString3 =
          fixtures('chatwheel_scraper', 'event_element3');

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
      String sampleDocumentString = fixtures('common', 'chatwheel_fullpage');
      final events = chatwheelScraper.getEvents2(sampleDocumentString);
      expect(events, TypeMatcher<ChatwheelEventResult>());
    });
  });
}
