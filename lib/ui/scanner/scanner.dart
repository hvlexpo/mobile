import 'package:flutter/material.dart';
import 'package:expo/ui/theme/theme.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:expo/ui/exhibitions/exhibition_view.dart';

class ScannerView extends StatefulWidget {
  final List<CameraDescription> cameras;
  ScannerView({Key key, this.cameras}) : super(key: key);

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerView> {
  String scannedText = '';
  QRReaderController controller;

  @override
  void initState() {
    super.initState();
    controller = new QRReaderController(
        widget.cameras[0], ResolutionPreset.high, [CodeFormat.qr],
        (dynamic value) {
      print(value);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ExhibitionView(exhibitionId: value),
        ),
      );
      new Future.delayed(const Duration(seconds: 1), controller.startScanning);
    });
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      controller.startScanning();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
                child: Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 1.0,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: QRReaderPreview(controller),
                      ),),
                ),),
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

  Widget _onError(dynamic error) {
    return Text(error.message);
  }

  Widget _qrPlaceholder(BuildContext context) {
    return Center(
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Center(
            child: Icon(Icons.camera),
          )),
    );
  }
}
