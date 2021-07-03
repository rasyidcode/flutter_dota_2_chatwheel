import 'package:built_collection/built_collection.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_event.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_event_result.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_line.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_pack.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:flutter_dota_2_chatwheel/extensions/element_extensions.dart';

class ChatwheelScraper {
  static const EVENT_CHATWHEEL_URL = 'https://dota2.fandom.com/wiki/Chat_Wheel';
  static const DOTA_PLUS_CHATWHEEL_URL =
      'https://dota2.fandom.com/wiki/Chat_Wheel/Dota_Plus';
  static const SUPPORTERS_CLUB_CHATWHEEL_URL =
      'https://dota2.fandom.com/wiki/Supporters_Club';

  ChatwheelEventResult getEventChatwheels(String responseBody) {
    final Document documentPage = parse(responseBody);
    final List<Element> rawEventChatwheels = documentPage.querySelectorAll(
        'table.wikitable.sortable > tbody > tr > td > ul > li > span > audio');
    final BuiltList<ChatwheelEvent> events = rawEventChatwheels
        .map((event) => getEvent(event)) as BuiltList<ChatwheelEvent>;
    return ChatwheelEventResult((b) => b..events.replace(events));
  }

  /// returns a single chatwheel line from a span element
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
  ChatwheelPack getPack(Element? audio) {
    audio.throwError(startsWith: '<audio');

    String packName = '';
    int bpLevel = 0;
    BuiltList<ChatwheelLine> lines = BuiltList<ChatwheelLine>();

    final Element? span = audio!.parent;
    span.throwError(startsWith: '<span>');

    final Element? li = span!.parent;
    li.throwError(startsWith: '<li>');

    final Element? ul = li!.parent;
    ul.throwError(startsWith: '<ul>');

    final Element? tdLines = ul!.parent;
    // print(tdLines?.outerHtml);
    tdLines.throwError(startsWith: '<td align="left"');

    List<Element> rawLines =
        tdLines!.querySelectorAll('ul > li > span > audio');
    lines = rawLines.map((rawLine) => getLine(rawLine)).toBuiltList();

    final Element? tdConsoleCommand = tdLines.previousElementSibling;
    tdConsoleCommand.throwError(startsWith: '<td align="left"');

    final Element? tdCheck = tdConsoleCommand!.previousElementSibling;

    tdCheck.throwError(startsWith: '<td');
    if (tdCheck!.text.trim().length > 4 && tdCheck.text.trim() != 'Unused') {
      packName = tdCheck.text.trim();
      final Element? tdBpLevel = tdCheck.previousElementSibling;
      tdBpLevel.throwError(startsWith: '<td');
      bpLevel = int.parse(tdBpLevel!.text.trim());
    } else {
      packName = 'bp${tdCheck.text.trim()}';
      if (tdCheck.text.trim() == 'Unused') {
        bpLevel = 0;
      } else {
        bpLevel = int.parse(tdCheck.text.trim());
      }
    }

    return ChatwheelPack((b) => b
      ..packName = packName
      ..bpLevel = bpLevel
      ..lines.replace(lines));
  }

  /// returns list of chatwheels packs with the event name
  ChatwheelEvent getEvent(Element? audio) {
    audio.throwError(startsWith: '<audio');

    final Element? span = audio!.parent;
    span.throwError(startsWith: '<span>');

    final Element? li = span!.parent;
    li.throwError(startsWith: '<li>');

    final Element? ul = li!.parent;
    ul.throwError(startsWith: '<ul>');

    final Element? td = ul!.parent;
    td.throwError(startsWith: '<td align="left">');

    final Element? tr = td!.parent;
    tr.throwError(startsWith: '<tr>');

    final Element? tbody = tr!.parent;
    tbody.throwError(startsWith: '<tbody>');

    final List<Element> packsElement =
        tbody!.querySelectorAll('tr > td > ul > li > span > audio');
    final BuiltList<ChatwheelPack> packs =
        packsElement.map((pack) => getPack(pack)).toBuiltList();

    final Element? table = tbody.parent;
    table.throwError(startsWith: '<table ');

    final Element? p = table!.previousElementSibling;
    p.throwError(startsWith: '<p>');

    final Element? h3 = p!.previousElementSibling;
    h3.throwError(startsWith: '<h3>');

    final Element? mwHeadline = h3!.querySelector('span.mw-headline');
    mwHeadline.throwError(startsWith: '<span class="mw-headline"');

    final String eventName = mwHeadline!.text;

    return ChatwheelEvent(
      (b) => b
        ..eventName = eventName
        ..packs.replace(packs),
    );
  }
}
