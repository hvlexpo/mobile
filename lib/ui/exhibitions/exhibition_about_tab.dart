import 'package:flutter/material.dart';
import 'package:expo/data/models/exhibition_model.dart';
import 'package:expo/utils/localization.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AboutTab extends StatelessWidget {
  final ExhibitionEntity exhibition;

  AboutTab(this.exhibition);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: AutoSizeText(exhibition.description ?? AppLocalizations.of(context).noDescription),
    );
  }
}
