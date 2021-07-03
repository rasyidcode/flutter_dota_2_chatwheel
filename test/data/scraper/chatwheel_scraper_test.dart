import 'dart:io';

import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_line.dart';
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

      final Document sampleDocument = parse(sampleDocumentString);
      final Element? span = sampleDocument.querySelector('li > span');
      final line = chatwheelScraper.getLine(span);

      expect(line, TypeMatcher<ChatwheelLine>());
      expect(line.name, 'Ba-dum tishh');
      expect(line.url,
          'https://static.wikia.nocookie.net/dota2_gamepedia/images/f/fc/Misc_soundboard_rimshot.mp3/revision/latest?cb=20190922222137');
    });
  });
}
