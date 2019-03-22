import 'package:flutter/material.dart';
import 'package:expo/ui/theme/expo_colors.dart';

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(ExpoColors.hvlPrimary),
      ),
    );
  }
}
