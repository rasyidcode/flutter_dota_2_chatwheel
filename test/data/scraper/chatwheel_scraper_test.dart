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

  group('getPack() test', () {
    test('should return ChatwheelPack model with no pack name column', () {
      String sampleDocumentString = fixtures('chatwheel_scraper/getPack',
          'chatwheel_pack_with_no_pack_name_column');

      final Document sampleDocument = parse(sampleDocumentString);
      final Element? tr = sampleDocument.querySelector('tr');
      final packs = chatwheelScraper.getPack(tr);

      expect(packs, TypeMatcher<ChatwheelPack>());
      expect(packs.packName, 'bp26');
      expect(packs.bpLevel, 26);
      expect(packs.lines, TypeMatcher<BuiltList<ChatwheelLine>>());
      expect(packs.lines.length, 6);
    });

    test('should return ChatwheelPack model with pack name column', () {
      String sampleDocumentString2 =
          fixtures('chatwheel_scraper', 'pack_element2');

      final Document sampleDocument2 = parse(sampleDocumentString2);
      final Element? tr = sampleDocument2.querySelector('tr');
      final packs = chatwheelScraper.getPack(tr);

      expect(packs, TypeMatcher<ChatwheelPack>());
      expect(packs.packName, 'Sound Pack 1 (2017)');
      expect(packs.bpLevel, 24);
      expect(packs.lines, TypeMatcher<ChatwheelLine>());
      expect(packs.lines.length, 6);
    });

    test('should return ChatwheelPack model with only 1 audio', () {
      String sampleDocumentString = fixtures(
          'chatwheel_scraper/getPack', 'chatwheel_pack_with_only_1_audio.html');
      final Document sampleDocument = parse(sampleDocumentString);
      final Element? tr = sampleDocument.querySelector('tr');
      final packs = chatwheelScraper.getPack(tr);

      expect(packs, TypeMatcher<ChatwheelPack>());
    });

    test('should return ChatwheelPack model with unused pack name', () {
      String sampleDocumentString = fixtures(
          'chatwheel_scraper/getPack', 'chatwheel_pack_with_unused_column');
      final Document sampleDocument = parse(sampleDocumentString);
      final Element? tr = sampleDocument.querySelector('tr');
      final packs = chatwheelScraper.getPack(tr);

      expect(packs, TypeMatcher<ChatwheelPack>());
    });
  });

  group('getEvent() test', () {
    test('should return either ChatwheelEvent or null value', () {
      String sampleDocumentString =
          fixtures('chatwheel_scraper', 'event_element');

      final Document sampleDocument = parse(sampleDocumentString);

      final Element? table = sampleDocument.querySelector('table');

      final event = chatwheelScraper.getEvent(table);

      expect(event, TypeMatcher<ChatwheelEvent>());
    });

    test('should return either ChatwheelEvent or null value', () {
      String sampleDocumentString2 =
          fixtures('chatwheel_scraper', 'event_element2');

      final Document sampleDocument2 = parse(sampleDocumentString2);

      final Element? table2 = sampleDocument2.querySelector('table');

      final event2 = chatwheelScraper.getEvent(table2);

      expect(event2, TypeMatcher<ChatwheelEvent>());
    });

    test('should return either ChatwheelEvent or null value', () {
      String sampleDocumentString3 =
          fixtures('chatwheel_scraper', 'event_element3');

      final Document sampleDocument3 = parse(sampleDocumentString3);

      final Element? table3 = sampleDocument3.querySelector('table');

      final event3 = chatwheelScraper.getEvent(table3);

      expect(event3, null);
    });
  });

  group('getEvents() test', () {
    test('should return a ChatwheelEventResult', () {
      String sampleDocumentString = fixtures('common', 'chatwheel_fullpage');
      final events = chatwheelScraper.getEvents(sampleDocumentString);
      expect(events, TypeMatcher<ChatwheelEventResult>());
    });
  });
}
