import 'package:flutter/material.dart';
import 'package:expo/ui/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:built_collection/built_collection.dart';
import 'package:expo/data/models/user_model.dart';
import 'package:expo/data/repositories/user_repository.dart';

class ProfileView extends StatelessWidget {
  final UserRepository repository = UserRepository();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserEntity>(
      future: repository.fetchCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                Text(
                  'Hello, ${snapshot.data.displayName}!',
                  style: TextStyle(
                      color: ExpoColors.hvlAccent,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Dine stemmer',
                  style: TextStyle(color: ExpoColors.hvlAccent, fontSize: 24),
                ),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: repository.fetchUserVotes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data
                            .map((map) => Text(map['weight']))
                            .toList(),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
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
