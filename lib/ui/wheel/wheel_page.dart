import 'dart:math';

import 'package:flutter/material.dart';

const double CHATWHEEL_SIZE = 150;
const double CHATWHEEL_PADDING = 30;
const double DIAGONAL_VALUE = 29.5;
const double CHATWHEEL_RADIUS = 110;

class WheelPage extends StatefulWidget {
  WheelPage({Key? key}) : super(key: key);

  @override
  _WheelPageState createState() => _WheelPageState();
}

class _WheelPageState extends State<WheelPage> {
  Offset delta = Offset.zero;

  // drag handler
  bool topLeftFired = false;
  bool topCenterFired = false;
  bool topRightFired = false;
  bool rightCenterFired = false;
  bool bottomRightFired = false;
  bool bottomCenterFired = false;
  bool bottomLeftFired = false;
  bool leftCenterFired = false;

  double textOpacity = 0;

  double tlDotOpacity = 0;
  double tcDotOpacity = 0;
  double trDotOpacity = 0;
  double rcDotOpacity = 0;
  double brDotOpacity = 0;
  double bcDotOpacity = 0;
  double blDotOpacity = 0;
  double lcDotOpacity = 0;

  String tlLine = 'ASDF 1';
  String tcLine = 'ASDF 2';
  String trLine = 'ASDF 3';
  String rcLine = 'ASDF 4';
  String brLine = 'ASDF 5';
  String bcLine = 'ASDF 6';
  String blLine = 'ASDF 7';
  String lcLine = 'ASDF 8';

  String currentActiveLine = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //--------- Start of function-----------------------//
  void updateDelta(Offset newDelta) {
    // top left position
    if ((newDelta.dy >= -50 && newDelta.dy <= -30) &&
        (newDelta.dx >= -50 && newDelta.dx <= -30)) {
      topLeftFired = true;
      setState(() {
        tlDotOpacity = 1;
        currentActiveLine = tlLine;
      });
    }

    // top center position
    if ((newDelta.dy >= -60 && newDelta.dy <= -40) &&
        (newDelta.dx >= -10 && newDelta.dx <= 10)) {
      topCenterFired = true;
      setState(() {
        tcDotOpacity = 1;
        currentActiveLine = tcLine;
      });
    }

    // top right position
    if ((newDelta.dy >= -50 && newDelta.dy <= -30) &&
        (newDelta.dx >= 30 && newDelta.dx <= 50)) {
      topRightFired = true;
      setState(() {
        trDotOpacity = 1;
        currentActiveLine = trLine;
      });
    }

    // right center position
    if ((newDelta.dx >= 40 && newDelta.dx <= 60) &&
        (newDelta.dy >= -10 && newDelta.dy <= 10)) {
      rightCenterFired = true;
      setState(() {
        rcDotOpacity = 1;
        currentActiveLine = rcLine;
      });
    }

    // bottom right position
    if ((newDelta.dx >= 30 && newDelta.dx <= 50) &&
        (newDelta.dy >= 30 && newDelta.dy <= 50)) {
      bottomRightFired = true;
      setState(() {
        brDotOpacity = 1;
        currentActiveLine = brLine;
      });
    }

    // bottom center position
    if ((newDelta.dx >= -10 && newDelta.dx <= 10) &&
        (newDelta.dy >= 40 && newDelta.dy <= 60)) {
      bottomCenterFired = true;
      setState(() {
        bcDotOpacity = 1;
        currentActiveLine = bcLine;
      });
    }

    // bottom left position
    if ((newDelta.dx >= -50 && newDelta.dx <= -30) &&
        (newDelta.dy >= 30 && newDelta.dy <= 50)) {
      bottomLeftFired = true;
      setState(() {
        blDotOpacity = 1;
        currentActiveLine = blLine;
      });
    }

    // left center position
    if ((newDelta.dx >= -60 && newDelta.dx <= -40) &&
        (newDelta.dy >= -10 && newDelta.dy <= 10)) {
      leftCenterFired = true;
      setState(() {
        lcDotOpacity = 1;
        currentActiveLine = lcLine;
      });
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
    setState(() {
      textOpacity = 1;
      tlDotOpacity = 0.5;
      tcDotOpacity = 0.5;
      trDotOpacity = 0.5;
      rcDotOpacity = 0.5;
      brDotOpacity = 0.5;
      bcDotOpacity = 0.5;
      blDotOpacity = 0.5;
      lcDotOpacity = 0.5;
    });
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

    setState(() {
      tlDotOpacity = 0;
      tcDotOpacity = 0;
      trDotOpacity = 0;
      rcDotOpacity = 0;
      brDotOpacity = 0;
      bcDotOpacity = 0;
      blDotOpacity = 0;
      lcDotOpacity = 0;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        textOpacity = 0;
      });
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // chatwheel container widget
              Stack(
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
                      opacity: tlDotOpacity,
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
                      opacity: tcDotOpacity,
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
                      opacity: trDotOpacity,
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
                      opacity: rcDotOpacity,
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
                      opacity: brDotOpacity,
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
                      opacity: bcDotOpacity,
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
                      opacity: blDotOpacity,
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
                      opacity: lcDotOpacity,
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
              ),
              SizedBox(height: 50.0),
              // line widget
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Opacity(
                  opacity: textOpacity,
                  child: Tooltip(
                    message:
                        'We need to scan! Dararandaradarararan~ We need to scan!',
                    child: Text(
                      currentActiveLine,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
