import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
typedef DynamicCallback(dynamic value);

class QrReader extends StatefulWidget {
  final DynamicCallback onScanned;
  final DynamicCallback onError;

  QrReader({this.onScanned,this.onError, key}) : super(key: key);

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
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.8,
      height: MediaQuery.of(context).size.height*0.5,
      child: QrCamera(
        notStartedBuilder: _qrPlaceholder,
        qrCodeCallback: widget.onScanned,
        onError: (context, error) => widget.onError(error),
      ),
    );
  }

  Widget _qrPlaceholder(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.8,
      height: MediaQuery.of(context).size.height*0.5,
      child: Center(
        child: Icon(Icons.camera),
      )
    );
  }
}
