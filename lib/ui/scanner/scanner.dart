import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'qr_reader.dart';

class ScannerView extends StatefulWidget {
  ScannerView({Key key}) : super(key: key);

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerView> {
  String scannedText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: <Widget>[],
      ),
      backgroundColor: ExpoColors.hvlPrimary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)
              ),
              clipBehavior: Clip.hardEdge,
              child: QrReader(
                onError: _onError,
                onScanned: _onScanned,
              ),
            ),
          ),
          Text(
            scannedText,
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        label: Text(
          'Go back',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _onScanned(dynamic value) async {
    // TODO Implement post-scan processing and navigation
    setState(() {
      scannedText = value;
    });
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(value),
      backgroundColor: Colors.green,
    ));
  }

  void _onError(dynamic error) async {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Colors.red,
    ));
  }
}
