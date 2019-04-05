import 'package:flutter/material.dart';
import 'package:expo/data/models/exhibition_model.dart';

class AboutTab extends StatelessWidget {
  final ExhibitionEntity exhibition;

  AboutTab(this.exhibition);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(exhibition.description ?? 'No description')
      ],
    );
  }
}
