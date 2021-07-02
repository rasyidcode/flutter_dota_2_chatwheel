import 'dart:io';

import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_line.dart';
import 'package:flutter_dota_2_chatwheel/data/scraper/chatwheel_scraper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

void main() {
  String fixtures(String dirName, String name) =>
      File('test/data/fixtures/chatwheel_scraper/$dirName/$name.html')
          .readAsStringSync();
  final chatwheelScraper = ChatwheelScraper();

  group('chatwheel scrapper test | ', () {
    group('test getLine | ', () {
      test('returns ChatwheelLine and check it\'s properties', () {
        String sampleDocumentString =
            fixtures('getLine', 'single_chatwheel_element');

        final Document sampleDocument = parse(sampleDocumentString);
        final Element? span = sampleDocument.querySelector('li > span');
        final line = chatwheelScraper.getLine(span);

        expect(line, TypeMatcher<ChatwheelLine>());
        expect(line.name, 'Ba-dum tishh');
        expect(line.url,
            'https://static.wikia.nocookie.net/dota2_gamepedia/images/f/fc/Misc_soundboard_rimshot.mp3/revision/latest?cb=20190922222137');
      });

      test('returns NoElementFoundException if passing a null argument', () {
        expect(() => chatwheelScraper.getLine(null),
            throwsA(TypeMatcher<NoElementFoundException>()));
      });

      test(
          'returns ElementIsNotAsExpectedException if not passing a span element',
          () {
        String sampleDocumentString =
            fixtures('getLine', 'single_chatwheel_element_invalid');

        final Document sampleDocument = parse(sampleDocumentString);
        final Element? span = sampleDocument.querySelector('li > div');

        expect(() => chatwheelScraper.getLine(span),
            throwsA(TypeMatcher<ElementIsNotAsExpectedException>()));
      });

      test(
          'returns NoElementFoundException if span parent li is null or the element is a body tag',
          () {
        String sampleDocumentString =
            fixtures('getLine', 'single_chatwheel_element_span_no_parent');

        final Document sampleDocument = parse(sampleDocumentString);
        final Element? span = sampleDocument.querySelector('span');

        expect(() => chatwheelScraper.getLine(span),
            throwsA(TypeMatcher<NoElementFoundException>()));
      });

      test('returns ElementIsNotAsExpectedException if span parent is not li',
          () {
        String sampleDocumentString =
            fixtures('getLine', 'single_chatwheel_element_span_parent_not_li');

        final Document sampleDocument = parse(sampleDocumentString);
        final Element? span = sampleDocument.querySelector('span');

        expect(() => chatwheelScraper.getLine(span),
            throwsA(TypeMatcher<ElementIsNotAsExpectedException>()));
      });

      test(
          'returns NoElementFoundException if audio > source element returns null',
          () {
        String sampleDocumentString =
            fixtures('getLine', 'single_chatwheel_element_without_audio');

        final Document sampleDocument = parse(sampleDocumentString);
        final Element? span = sampleDocument.querySelector('span');

        expect(() => chatwheelScraper.getLine(span),
            throwsA(TypeMatcher<NoElementFoundException>()));
      });

      test(
          'returns NoSuchElementAttributeFoundException if audio > source element does\'t have src attribute',
          () {
        String sampleDocumentString = fixtures(
            'getLine', 'single_chatwheel_element_span_child_audio_no_src');

        final Document sampleDocument = parse(sampleDocumentString);
        final Element? span = sampleDocument.querySelector('span');

        expect(() => chatwheelScraper.getLine(span),
            throwsA(TypeMatcher<NoSuchElementAttributeFoundException>()));
      });
    });
  });
}
