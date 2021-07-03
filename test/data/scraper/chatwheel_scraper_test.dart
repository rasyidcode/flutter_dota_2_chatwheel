import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_event.dart';
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

  group('chatwheel scrapper test | ', () {
    test('returns ChatwheelLine and check it\'s properties', () {
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

      // print(line);
      // print(line2);
    });

    test('returns ChatwheelPack and check it\'s properties', () {
      String sampleDocumentString = fixtures('pack_element');
      String sampleDocumentString2 = fixtures('pack_element2');

      final Document sampleDocument = parse(sampleDocumentString);
      final Document sampleDocument2 = parse(sampleDocumentString2);

      final Element? span = sampleDocument.querySelector('li > span > audio');
      final Element? span2 = sampleDocument2.querySelector('li > span > audio');

      final packs = chatwheelScraper.getPack(span);
      final linesMatcher = BuiltList<ChatwheelLine>([
        ChatwheelLine((b) => b
          ..line = 'Ba-dum tishh'
          ..url =
              'https://static.wikia.nocookie.net/dota2_gamepedia/images/f/fc/Misc_soundboard_rimshot.mp3/revision/latest?cb=20190922222137'),
        ChatwheelLine((b) => b
          ..line = 'Charge'
          ..url =
              'https://static.wikia.nocookie.net/dota2_gamepedia/images/d/d6/Misc_soundboard_charge.mp3/revision/latest?cb=20190922222034'),
        ChatwheelLine((b) => b
          ..line = 'Frog'
          ..url =
              'https://static.wikia.nocookie.net/dota2_gamepedia/images/c/c9/Misc_soundboard_frog.mp3/revision/latest?cb=20190922222046'),
        ChatwheelLine((b) => b
          ..line = 'Crash and burn'
          ..url =
              'https://static.wikia.nocookie.net/dota2_gamepedia/images/b/ba/Misc_soundboard_crash_burn.mp3/revision/latest?cb=20190922222034'),
        ChatwheelLine((b) => b
          ..line = 'Applause'
          ..url =
              'https://static.wikia.nocookie.net/dota2_gamepedia/images/a/a4/Misc_crowd_lv_01.mp3/revision/latest?cb=20190922221550'),
        ChatwheelLine((b) => b
          ..line = 'Applause'
          ..url =
              'https://static.wikia.nocookie.net/dota2_gamepedia/images/5/54/Misc_crowd_lv_02.mp3/revision/latest?cb=20190922221551'),
      ]);

      final packs2 = chatwheelScraper.getPack(span2);
      final linesMatcher2 = BuiltList<ChatwheelLine>([
        ChatwheelLine((b) => b
          ..line = 'Ba-dum tishh'
          ..url =
              'https://static.wikia.nocookie.net/dota2_gamepedia/images/f/fc/Misc_soundboard_rimshot.mp3/revision/latest?cb=20190922222137'),
        ChatwheelLine((b) => b
          ..line = 'Charge'
          ..url =
              'https://static.wikia.nocookie.net/dota2_gamepedia/images/d/d6/Misc_soundboard_charge.mp3/revision/latest?cb=20190922222034'),
        ChatwheelLine((b) => b
          ..line = 'Frog'
          ..url =
              'https://static.wikia.nocookie.net/dota2_gamepedia/images/c/c9/Misc_soundboard_frog.mp3/revision/latest?cb=20190922222046'),
        ChatwheelLine((b) => b
          ..line = 'Crash and burn'
          ..url =
              'https://static.wikia.nocookie.net/dota2_gamepedia/images/b/ba/Misc_soundboard_crash_burn.mp3/revision/latest?cb=20190922222034'),
        ChatwheelLine((b) => b
          ..line = 'Applause'
          ..url =
              'https://static.wikia.nocookie.net/dota2_gamepedia/images/a/a4/Misc_crowd_lv_01.mp3/revision/latest?cb=20190922221550'),
        ChatwheelLine((b) => b
          ..line = 'Applause'
          ..url =
              'https://static.wikia.nocookie.net/dota2_gamepedia/images/5/54/Misc_crowd_lv_02.mp3/revision/latest?cb=20190922221551'),
      ]);

      expect(packs, TypeMatcher<ChatwheelPack>());

      expect(packs.bpLevel, TypeMatcher<int>());
      expect(packs.bpLevel, 26);

      expect(packs.packName, TypeMatcher<String>());
      expect(packs.packName, 'bp26');

      expect(packs.lines, TypeMatcher<BuiltList<ChatwheelLine>>());
      expect(packs.lines.length, linesMatcher.length);
      expect(packs.lines, linesMatcher);

      expect(packs2, TypeMatcher<ChatwheelPack>());
      expect(packs2.bpLevel, TypeMatcher<int>());
      expect(packs2.bpLevel, 24);

      expect(packs2.packName, TypeMatcher<String>());
      expect(packs2.packName, 'Sound Pack 1 (2017)');

      expect(packs2.lines, TypeMatcher<BuiltList<ChatwheelLine>>());
      expect(packs2.lines.length, linesMatcher2.length);
      expect(packs2.lines, linesMatcher2);
    });

    test('returns List of ChatwheelPack and check it\'s properties', () {
      String sampleDocumentString = fixtures('event_element');

      final Document sampleDocument = parse(sampleDocumentString);
      final Element? span = sampleDocument.querySelector(
          'table.wikitable.sortable > tbody > tr > td > ul > li > span > audio');
      final event = chatwheelScraper.getEvent(span);
      expect(event, TypeMatcher<ChatwheelEvent>());
    });
  });
}
