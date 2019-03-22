import 'package:flutter/material.dart';

typedef DynamicCallback(dynamic value);

class QrReader extends StatefulWidget {
  final DynamicCallback onScanned;

  QrReader({this.onScanned, key}) : super(key: key);

  _QrReaderState createState() => _QrReaderState();
}

class _QrReaderState extends State<QrReader> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO Implement QR scanner
    return Container();
  }
}
