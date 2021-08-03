import 'dart:math';
import 'package:flutter/material.dart';

//This Part is about Joypad , return Ofsset Position
class Joypad extends StatefulWidget {
  const Joypad({
    Key? key,
  }) : super(key: key);

  JoypadState createState() => JoypadState();
}

const double CHATWHEEL_SIZE = 150;
const double CHATWHEEL_PADDING = 30;
const double DIAGONAL_VALUE = 29.5;
const double CHATWHEEL_RADIUS = 110;

class JoypadState extends State {
  Offset delta = Offset.zero;

  bool topLeftFired = false;
  bool topCenterFired = false;
  bool topRightFired = false;
  bool rightCenterFired = false;
  bool bottomRightFired = false;
  bool bottomCenterFired = false;
  bool bottomLeftFired = false;
  bool leftCenterFired = false;

  @override
  void initState() {
    super.initState();
  }

  //--------- Start of function-----------------------//
  void updateDelta(Offset newDelta) {
    // top left position
    if ((newDelta.dy >= -50 && newDelta.dy <= -30) &&
        (newDelta.dx >= -50 && newDelta.dx <= -30)) {
      topLeftFired = true;
    }

    // top center position
    if ((newDelta.dy >= -60 && newDelta.dy <= -40) &&
        (newDelta.dx >= -10 && newDelta.dx <= 10)) {
      topCenterFired = true;
    }

    // top right position
    if ((newDelta.dy >= -50 && newDelta.dy <= -30) &&
        (newDelta.dx >= 30 && newDelta.dx <= 50)) {
      topRightFired = true;
    }

    // right center position
    if ((newDelta.dx >= 40 && newDelta.dx <= 60) &&
        (newDelta.dy >= -10 && newDelta.dy <= 10)) {
      rightCenterFired = true;
    }

    // bottom right position
    if ((newDelta.dx >= 30 && newDelta.dx <= 50) &&
        (newDelta.dy >= 30 && newDelta.dy <= 50)) {
      bottomRightFired = true;
    }

    // bottom center position
    if ((newDelta.dx >= -10 && newDelta.dx <= 10) &&
        (newDelta.dy >= 40 && newDelta.dy <= 60)) {
      bottomCenterFired = true;
    }

    // bottom left position
    if ((newDelta.dx >= -50 && newDelta.dx <= -30) &&
        (newDelta.dy >= 30 && newDelta.dy <= 50)) {
      bottomLeftFired = true;
    }

    // left center position
    if ((newDelta.dx >= -60 && newDelta.dx <= -40) &&
        (newDelta.dy >= -10 && newDelta.dy <= 10)) {
      leftCenterFired = true;
    }

    setState(() {
      delta = newDelta;
    });
  }

  void calculateDelta(Offset offset) {
    Offset newDelta = offset - Offset(60, 60);
    updateDelta(
      Offset.fromDirection(
        newDelta.direction,
        min(60, newDelta.distance),
      ),
    );
  }

  void onDragDown(DragDownDetails d) {
    calculateDelta(d.localPosition);
  }

  void onDragUpdate(DragUpdateDetails d) {
    calculateDelta(d.localPosition);
  }

  void onDragEnd(DragEndDetails d) {
    if (topLeftFired) handleTopLeftFired();

    if (topCenterFired) handleTopCenterFired();

    if (topRightFired) handleTopRightFired();

    if (rightCenterFired) handleRightCenterFired();

    if (bottomRightFired) handleBottomRightFired();

    if (bottomCenterFired) handleBottomCenterFired();

    if (bottomLeftFired) handleBottomLeftFired();

    if (leftCenterFired) handleLeftCenterFired();

    updateDelta(Offset.zero);
  }

  void resetChatwheel() {
    topLeftFired = false;
    topCenterFired = false;
    topRightFired = false;
    rightCenterFired = false;
    bottomRightFired = false;
    bottomCenterFired = false;
    bottomLeftFired = false;
    leftCenterFired = false;
  }

  void handleTopLeftFired() {
    resetChatwheel();
  }

  void handleTopCenterFired() {
    resetChatwheel();
  }

  void handleTopRightFired() {
    resetChatwheel();
  }

  void handleRightCenterFired() {
    resetChatwheel();
  }

  void handleBottomRightFired() {
    resetChatwheel();
  }

  void handleBottomCenterFired() {
    resetChatwheel();
  }

  void handleBottomLeftFired() {
    resetChatwheel();
  }

  void handleLeftCenterFired() {
    resetChatwheel();
  }

  //--------- End of function-----------------------//

  //--------- Start of widget-----------------------//
  Widget _buildChatwheel() => SizedBox(
        height: CHATWHEEL_SIZE,
        width: CHATWHEEL_SIZE,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(75),
          ),
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 10.0, color: Colors.white30)),
              child: Center(
                child: Transform.translate(
                  offset: delta,
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xccffffff),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            onPanDown: onDragDown,
            onPanUpdate: onDragUpdate,
            onPanEnd: onDragEnd,
          ),
        ),
      );
  //--------- End of widget-----------------------//

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(CHATWHEEL_PADDING),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(CHATWHEEL_RADIUS),
          ),
          child: _buildChatwheel(),
        ),
        // top left
        Positioned(
          child: Opacity(
            opacity: 1,
            child: SizedBox(
              height: 10.0,
              width: 10.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
          top: DIAGONAL_VALUE,
          left: DIAGONAL_VALUE,
        ),
        // top center
        Positioned(
          child: Opacity(
            opacity: 1,
            child: SizedBox(
              height: 10.0,
              width: 10.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          top: 0,
          left: (CHATWHEEL_SIZE + CHATWHEEL_PADDING) / 2 + 10,
        ),
        // top right
        Positioned(
          child: Opacity(
            opacity: 1,
            child: SizedBox(
              height: 10.0,
              width: 10.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
          top: DIAGONAL_VALUE,
          right: DIAGONAL_VALUE,
        ),
        // right center
        Positioned(
          child: Opacity(
            opacity: 1,
            child: SizedBox(
              height: 10.0,
              width: 10.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
          bottom: (CHATWHEEL_SIZE + CHATWHEEL_PADDING) / 2 + 10,
          right: 0,
        ),
        // bottom right
        Positioned(
          child: Opacity(
            opacity: 1,
            child: SizedBox(
              height: 10.0,
              width: 10.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
          bottom: DIAGONAL_VALUE,
          right: DIAGONAL_VALUE,
        ),
        // bottom center
        Positioned(
          child: Opacity(
            opacity: 1,
            child: SizedBox(
              height: 10.0,
              width: 10.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
          bottom: 0,
          right: (CHATWHEEL_SIZE + CHATWHEEL_PADDING) / 2 + 10,
        ),
        // bottom left
        Positioned(
          child: Opacity(
            opacity: 1,
            child: SizedBox(
              height: 10.0,
              width: 10.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
          bottom: DIAGONAL_VALUE,
          left: DIAGONAL_VALUE,
        ),
        // left center
        Positioned(
          child: Opacity(
            opacity: 1,
            child: SizedBox(
              height: 10.0,
              width: 10.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
          bottom: (CHATWHEEL_SIZE + CHATWHEEL_PADDING) / 2 + 10,
          left: 0,
        ),
      ],
    );
  }
}
