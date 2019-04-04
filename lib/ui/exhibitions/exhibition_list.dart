import 'package:flutter/material.dart';
import 'package:expo/data/repositories/exhibition_repository.dart';
import 'package:expo/ui/exhibitions/exhibition_tile.dart';
import 'package:expo/data/models/exhibition_model.dart';
import 'package:built_collection/built_collection.dart';

class ExhibitionList extends StatelessWidget {
  final repository = ExhibitionRepository();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BuiltList<ExhibitionEntity>>(
      future: repository.loadList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              final exhibition = snapshot.data[index];

              return Padding(
                padding: EdgeInsets.only(bottom: 10, left: 5, right: 5),
                child: ExhibitionTile(exhibition: exhibition));
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
