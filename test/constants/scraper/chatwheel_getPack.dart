import 'package:built_collection/built_collection.dart';
import 'package:flutter_dota_2_chatwheel/data/model/network/chatwheel_line.dart';
import 'package:flutter_dota_2_chatwheel/data/model/network/chatwheel_pack.dart';

final packData1 = ChatwheelPack(
  (b) => b
    ..packName = 'bp26'
    ..bpLevel = 26
    ..lines.replace(
      BuiltList<ChatwheelLine>([
        ChatwheelLine(
          (b) => b
            ..line = 'Ba-dum tishh'
            ..lineTranslate = null
            ..url =
                'https://static.wikia.nocookie.net/dota2_gamepedia/images/f/fc/Misc_soundboard_rimshot.mp3/revision/latest?cb=20190922222137',
        ),
        ChatwheelLine(
          (b) => b
            ..line = 'Charge'
            ..lineTranslate = null
            ..url =
                'https://static.wikia.nocookie.net/dota2_gamepedia/images/d/d6/Misc_soundboard_charge.mp3/revision/latest?cb=20190922222034',
        ),
        ChatwheelLine(
          (b) => b
            ..line = 'Frog'
            ..lineTranslate = null
            ..url =
                'https://static.wikia.nocookie.net/dota2_gamepedia/images/c/c9/Misc_soundboard_frog.mp3/revision/latest?cb=20190922222046',
        ),
        ChatwheelLine(
          (b) => b
            ..line = 'Crash'
            ..lineTranslate = null
            ..url =
                'https://static.wikia.nocookie.net/dota2_gamepedia/images/b/ba/Misc_soundboard_crash_burn.mp3/revision/latest?cb=20190922222034',
        ),
        ChatwheelLine(
          (b) => b
            ..line = 'Applause'
            ..lineTranslate = null
            ..url =
                'https://static.wikia.nocookie.net/dota2_gamepedia/images/a/a4/Misc_crowd_lv_01.mp3/revision/latest?cb=20190922221550',
        ),
        ChatwheelLine(
          (b) => b
            ..line = 'Applause'
            ..lineTranslate = null
            ..url =
                'https://static.wikia.nocookie.net/dota2_gamepedia/images/5/54/Misc_crowd_lv_02.mp3/revision/latest?cb=20190922221551',
        )
      ]),
    ),
);
