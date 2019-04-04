import 'package:flutter/material.dart';
import 'package:expo/data/models/exhibition_model.dart';

class ExhibitionView extends StatelessWidget {
  final String exhibitionId;

  ExhibitionView({this.exhibitionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Text(exhibitionId);
          } else {
            return CircularProgressIndicator();
          }
        },
      )
    );
  }
}