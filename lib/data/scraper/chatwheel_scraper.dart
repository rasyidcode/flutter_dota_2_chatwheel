import 'package:built_collection/built_collection.dart';
import 'package:flutter_dota_2_chatwheel/data/model/network/chatwheel_event.dart';
import 'package:flutter_dota_2_chatwheel/data/model/network/chatwheel_event_result.dart';
import 'package:flutter_dota_2_chatwheel/data/model/network/chatwheel_line.dart';
import 'package:flutter_dota_2_chatwheel/data/model/network/chatwheel_pack.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:flutter_dota_2_chatwheel/extensions/element_extensions.dart';

/// Simple chat wheel scraper spesific for ttps://dota2.fandom.com/wiki/Chat_Wheel page
class ChatwheelScraper {
  /// returns a single chatwheel line from an audio element
  ChatwheelLine getLine(Element? audio) {
    audio.throwError(startsWith: '<audio');

    String lane = '';
    String url = '';
    String? translate;

    final Element? span = audio!.parent;
    span.throwError(startsWith: '<span>');

    final Element? spanNext = span!.nextElementSibling;
    if (spanNext != null && spanNext.className == 'tooltip') {
      translate = spanNext.attributes['title'];
    }

    final Element? li = span.parent;
    li.throwError(startsWith: '<li>');
    lane = li!.text
        .replaceAll('Link▶️', '')
        .replaceAll('Link', '')
        .replaceAll(RegExp('\\s+'), ' ')
        .trim();

    final Element? audioSource = span.querySelector('audio > source');
    audioSource.throwError(startsWith: '<source');
    url = audioSource!.attributes['src'] ?? '';

    return ChatwheelLine((b) => b
      ..line = lane
      ..lineTranslate = translate
      ..url = url);
  }

  /// returns list of chatwheels with packname and bp levels
  ChatwheelPack getPack(Element? tr) {
    tr.throwError(startsWith: '<tr>');

    String packName = '';
    int bpLevel = 0;
    BuiltList<ChatwheelLine> lines = BuiltList<ChatwheelLine>();

    if (tr!.children.length == 3) {
      try {
        bpLevel = int.parse(tr.children[0].text.trim());
        packName = 'bp$bpLevel';
      } on FormatException catch (_) {
        bpLevel = 0;
        packName = tr.children[0].text.trim();
      }
    } else if (tr.children.length == 4) {
      try {
        packName = tr.children[1].text.trim();
        bpLevel = int.parse(tr.children[0].text.trim());
      } on FormatException catch (_) {
        bpLevel = 0;
        packName = tr.children[1].text.trim();
      }
    }

    List<Element> rawLines = tr.querySelectorAll('td > ul > li > span > audio');
    lines = rawLines.map((rawLine) => getLine(rawLine)).toBuiltList();

    return ChatwheelPack((b) => b
      ..packName = packName
      ..bpLevel = bpLevel
      ..lines.replace(lines));
  }

  /// returns list of chatwheels packs with the event name
  ChatwheelEvent? getEvent(Element? table) {
    table.throwError(startsWith: '<table');

    final Element? lastThHeader = table!.querySelectorAll('thead tr th').last;
    lastThHeader.throwError(startsWith: '<th');
    if (lastThHeader!.text.trim() == 'Sprays') {
      return null;
    }

    String eventName = '';
    BuiltList<ChatwheelPack> packs = BuiltList<ChatwheelPack>();

    final Element? p = table.previousElementSibling;
    p.throwError(startsWith: '<p>');

    Element? h3 = p!.previousElementSibling;
    h3.throwError(startsWith: '<h3>', orStartsWith: '<h4>');
    if (h3!.outerHtml.startsWith('<h4>')) {
      h3 = h3.previousElementSibling;
    }
    final Element? span = h3!.querySelector('span.mw-headline');
    eventName = span!.text.toString();

    final List<Element> packsElement = table.querySelectorAll('tbody tr');
    packs = packsElement.map((pack) => getPack(pack)).toBuiltList();

    return ChatwheelEvent(
      (b) => b
        ..eventName = eventName
        ..packs.replace(packs),
    );
  }

  /// returns all events that available on the page
  ChatwheelEventResult getEvents(String responseBody) {
    final Document documentPage = parse(responseBody);
    final List<Element> rawEventChatwheels =
        documentPage.querySelectorAll('table.wikitable.sortable');
    final BuiltList<ChatwheelEvent?> events =
        rawEventChatwheels.map((event) => getEvent(event)).toBuiltList();
    return ChatwheelEventResult((b) => b..events.replace(events));
  }
}
