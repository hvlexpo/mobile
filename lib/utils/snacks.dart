import 'package:flutter/material.dart';

class Snacks {
  static get errorSnack {
    return SnackBar(
      content: Text('Could not start camera. Do you even have one?'),
      backgroundColor: Colors.red,
    );
  }
}
