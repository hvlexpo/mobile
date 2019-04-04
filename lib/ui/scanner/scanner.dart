import 'package:flutter/material.dart';
import 'package:expo/ui/theme/theme.dart';
import 'package:expo/ui/scanner/qr_reader.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:expo/ui/exhibitions/exhibition_view.dart';

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
                  borderRadius: BorderRadius.circular(25)),
              clipBehavior: Clip.hardEdge,
              child: Center(child: SizedBox(
      
      width: MediaQuery.of(context).size.width*1.0,
      height: MediaQuery.of(context).size.height*0.5,
      child: QrCamera(
        notStartedBuilder: _qrPlaceholder,
        qrCodeCallback: (value) => _onScanned(value),
        onError: (context, error) => _onError(error),
      ),
    ),
    )
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

  void _onScanned(String value) async {
    // TODO Implement post-scan processing and navigation
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ExhibitionView(exhibitionId: value),
      ),
    );
  }

  Widget _onError(dynamic error) {
    return Text(error.message);
  }

  Widget _qrPlaceholder(BuildContext context) {
    return Center(child: SizedBox(
      width: MediaQuery.of(context).size.width*0.6,
      height: MediaQuery.of(context).size.height*0.5,
      child: Center(
        child: Icon(Icons.camera),
      )
    ),
    );
  }
}
