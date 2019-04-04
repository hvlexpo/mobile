import 'package:flutter/material.dart';
import 'package:expo/ui/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expo/data/repositories/user_repository.dart';

class ProfileView extends StatelessWidget {
  final UserRepository repository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: repository.fetchCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Text(
                    'Dine stemmer',
                    style: TextStyle(color: ExpoColors.hvlAccent, fontSize: 32),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
