import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_event.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_event_result.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_line.dart';
import 'package:flutter_dota_2_chatwheel/data/model/chatwheel_pack.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
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
        'table.wikitable.sortable > tbody > tr > td > ul > li > span');
    final BuiltList<ChatwheelEvent> events = rawEventChatwheels
        .map((item) => mappedChatwheel(item)) as BuiltList<ChatwheelEvent>;
    return ChatwheelEventResult(
        (b) => b..events.replace(BuiltList<ChatwheelEvent>()));
  }

  ChatwheelEvent mappedChatwheel(Element spanElement) {
    final Element? liElement = spanElement.parent;
    if (liElement != null) {
      if (liElement.outerHtml.startsWith('pattern')) {}
    }
    final Element? ulElement = liElement?.parent;
    final Element? tdElement = ulElement?.parent;
    final Element? trElement = tdElement?.parent;
    final Element? tbodyElement = trElement?.parent;
    final Element? tableElement = tbodyElement?.parent;
    final Element? pElement = tableElement?.previousElementSibling;
    final Element? h3Element = pElement?.previousElementSibling;
    final Element? mwHeadline = h3Element?.querySelector('span.mw-headline');

    final String? eventName = mwHeadline?.text;

    return ChatwheelEvent((b) => b
      ..eventName = eventName ?? ''
      ..packs.replace(
        BuiltList<ChatwheelPack>(),
      ));
  }

  /// returns a single chatwheel line from a span element
  ChatwheelLine getLine(Element? span) {
    span.throwError(startsWith: '<span>');

    String name = '';
    String url = '';

    final Element? li = span!.parent;
    li.throwError(startsWith: '<li>');
    name = li!.text.replaceAll('Link▶️', '').replaceAll('Link', '').trim();

    final Element? audioSource = span.querySelector('audio > source');
    audioSource.throwError(startsWith: '<source');
    url = audioSource!.attributes['src'] ?? '';

    return ChatwheelLine((b) => b
      ..name = name
      ..url = url);
  }

  ChatwheelPack getPack(Element? span) {
    String packName = '';
    int bpLevel = 0;
    BuiltList<ChatwheelLine> lines = BuiltList<ChatwheelLine>();

    if (span != null) {
      if (span.outerHtml.startsWith('<span>')) {
      } else {
        // throw ElementIsNotAsExpectedException();
      }
    } else {
      throw NoElementFoundException();
    }

    final Element? li = span.parent;
    if (li == null) throw NoElementFoundException();
    final Element? ul = li.parent;
    if (ul == null) throw NoElementFoundException();
    final Element? tdLines = ul.parent;
    final Element? tdConsoleCommand = tdLines?.parent;
    final Element? tdCheck = tdConsoleCommand?.parent;

    if (ul != null) {
      if (tdLines != null) {
        List<Element> rawLines =
            tdLines.querySelectorAll('span > audio > source');
        lines = rawLines.map((rawLine) => getLine(rawLine))
            as BuiltList<ChatwheelLine>;

        if (tdConsoleCommand != null) {
          if (tdCheck != null) {
            if (tdCheck.text.length > 4) {
            } else {
              packName = 'bp${tdCheck.text.trim()}';
              bpLevel = int.parse(tdCheck.text.trim());
            }
          } else {
            throw NoElementFoundException();
          }
        } else {
          throw NoElementFoundException();
        }
      } else {
        throw NoElementFoundException();
      }
    } else {
      throw NoElementFoundException();
    }

    return ChatwheelPack((b) => b
      ..packName = packName
      ..bpLevel = bpLevel
      ..lines.replace(lines));
  }

  BuiltList<ChatwheelPack> getChatwheelPacks(Element item) {
    BuiltList<ChatwheelPack> packs = BuiltList<ChatwheelPack>();
    final String? tdText = item
        .parent?.parent?.previousElementSibling?.previousElementSibling?.text;
    if (tdText != null) {
      if (tdText.length > 4) {}
    }
    return packs;
  }
}
