import 'package:flutter/material.dart';
import 'package:expo/ui/theme/theme.dart';

typedef StringCallback(String digit);

class PinKeyboard extends StatelessWidget {
  PinKeyboard({Key key, this.onKeyPressed, this.height, this.width})
      : super(key: key);

  final StringCallback onKeyPressed;
  final double height;
  final double width;

  final List<String> numbers = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    ' ',
    '0',
    ' '
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: GridView(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        children: numbers
            .map((i) => FlatButton(
                  splashColor:
                      i != ' ' ? ExpoColors.hvlAccent : Colors.transparent,
                  padding: EdgeInsets.all(0),
                  child: Text(
                    i,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 32),
                  ),
                  onPressed: i != ' '
                      ? () {
                          onKeyPressed(i);
                        }
                      : null,
                ))
            .toList(),
      ),
    );
  }
}
