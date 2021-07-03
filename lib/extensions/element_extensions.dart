import 'package:html/dom.dart';

extension ElementExtensions on Element? {
  throwError({required String startsWith}) {
    if (this == null) throw NoElementFoundException();
    if (!this!.outerHtml.startsWith(startsWith))
      throw NoElementFoundException();
  }
}

class NoElementFoundException implements Exception {
  final String message = 'No element found';
}
