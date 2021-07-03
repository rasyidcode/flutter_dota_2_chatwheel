import 'package:html/dom.dart';

extension ElementExtensions on Element? {
  throwError({required String startsWith, String? orStartsWith}) {
    if (this == null) throw NoElementFoundException();
    if (orStartsWith != null) {
      if (!this!.outerHtml.startsWith(startsWith) ||
          !this!.outerHtml.startsWith(orStartsWith))
        throw NoElementFoundException();
    } else {
      if (!this!.outerHtml.startsWith(startsWith))
        throw NoElementFoundException();
    }
  }
}

class NoElementFoundException implements Exception {
  final String message = 'No element found';
}
