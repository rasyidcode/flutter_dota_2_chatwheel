import 'package:flutter/material.dart';

class PositionedDotButton extends StatelessWidget {
  final Function() onTap;
  final Color color;
  final double radius;
  final double? top;
  final double? left;
  final double? bottom;
  final double? right;

  const PositionedDotButton(
      {Key? key,
      required this.onTap,
      this.color = Colors.white54,
      this.radius = 10.0,
      this.top,
      this.bottom,
      this.right,
      this.left})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      left: left,
      right: right,
      top: top,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius * 2),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: radius,
            height: radius,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
