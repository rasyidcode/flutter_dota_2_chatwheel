import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:flutter_dota_2_chatwheel/extensions/element_extensions.dart';

void main() {
  String fixtures(String dirName, String name) =>
      File('test/data/fixtures/extensions/$dirName/$name.html')
          .readAsStringSync();
  group('test the element_extensions', () {
    test('throwError test', () {
      String sampleDocumentString =
          fixtures('element_extensions', 'simple_element');
      final Document sampleDocument = parse(sampleDocumentString);
      final Element? span = null;
      final Element? span2 = sampleDocument.querySelector('li > span');

      expect(() => span.throwError(startsWith: '<div>'),
          throwsA(TypeMatcher<NoElementFoundException>()));
      expect(() => span2.throwError(startsWith: '<div>'),
          throwsA(TypeMatcher<NoElementFoundException>()));
    });
  });
}
