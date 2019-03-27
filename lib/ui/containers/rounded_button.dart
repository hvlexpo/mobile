import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final Color color;
  final double borderRadius;
  final Function onPressed;

  const RoundedButton({
    Key key,
    @required this.child,
    this.width = 250,
    this.height = 50,
    this.borderRadius = 30,
    this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
