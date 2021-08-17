import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math' as math;

class BasicWheelPage extends StatefulWidget {
  BasicWheelPage({Key? key}) : super(key: key);

  @override
  _BasicWheelPageState createState() => _BasicWheelPageState();
}

class _BasicWheelPageState extends State<BasicWheelPage> {
  AudioPlayer _audioPlayer = AudioPlayer();
  AudioCache _audioCache = AudioCache();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playChatwheel(String chatwheelName) async {
    final audioStringUri = await _audioCache.load(chatwheelName);

    await _audioPlayer.stop();
    await _audioPlayer.play(audioStringUri.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.0),
            Container(
              color: Colors.blue,
              width: 180,
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(180 / 360),
                        child: IconButton(
                          color: Colors.red,
                          onPressed: () =>
                              _playChatwheel('absolutely_perfect.mp3'),
                          icon: Icon(Icons.arrow_drop_down_circle),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(135 / 360),
                        child: IconButton(
                          color: Colors.green,
                          onPressed: () => _playChatwheel('ceeeb_start.mp3'),
                          icon: Icon(Icons.arrow_drop_down_circle),
                        ),
                      ),
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(225 / 360),
                        child: IconButton(
                          onPressed: () => _playChatwheel('easiest_money.mp3'),
                          icon: Icon(Icons.arrow_drop_down_circle),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(90 / 360),
                        child: IconButton(
                          onPressed: () => _playChatwheel('ehto_g_g.mp3'),
                          icon: Icon(Icons.arrow_drop_down_circle),
                        ),
                      ),
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(270 / 360),
                        child: IconButton(
                          onPressed: () =>
                              _playChatwheel('eto_prosto_netchto.mp3'),
                          icon: Icon(Icons.arrow_drop_down_circle),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(45 / 360),
                        child: IconButton(
                          onPressed: () => _playChatwheel('ni_qi_bu_qi.mp3'),
                          icon: Icon(Icons.arrow_drop_down_circle),
                        ),
                      ),
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(315 / 360),
                        child: IconButton(
                          onPressed: () => _playChatwheel('ta_daaaa.mp3'),
                          icon: Icon(Icons.arrow_drop_down_circle),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(0),
                        child: IconButton(
                          onPressed: () => _playChatwheel('youre_a_hero.mp3'),
                          icon: Icon(Icons.arrow_drop_down_circle),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
