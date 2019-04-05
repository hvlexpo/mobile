import 'package:flutter/material.dart';
import 'package:expo/data/models/exhibition_model.dart';

class CreatorTab extends StatelessWidget {
  final ExhibitionEntity exhibition;
  final List<String> names = [];

  CreatorTab(this.exhibition);

  @override
  Widget build(BuildContext context) {
    exhibition.creators.forEach((key, val) {
      names.add(val);
    });
    return Padding(
      padding: EdgeInsets.all(10),
      child: exhibition.creators != null
          ? Column(
              children: names
                  .map(
                    (name) => ListTile(
                          title: Text(name),
                          leading: Icon(Icons.account_circle),
                        ),
                  )
                  .toList())
          : ListTile(
              leading: Text('No creators'),
            ),
    );
  }
}
