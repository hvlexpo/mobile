import 'package:flutter/material.dart';
import 'package:expo/data/models/exhibition_model.dart';
import 'package:expo/ui/exhibitions/exhibition_default_view.dart';
import 'package:expo/data/repositories/exhibition_repository.dart';

class ExhibitionView extends StatelessWidget {
  final String exhibitionId;
  final ExhibitionRepository repository = ExhibitionRepository();

  ExhibitionView({this.exhibitionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ExhibitionEntity>(
        future: repository.fetchExhibitionById(exhibitionId),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ExhibitionDefaultView(snapshot.data, votable: true,);
          } else {
            return CircularProgressIndicator();
          }
        },
      )
    );
  }
}