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
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            child: Container(
              child: Column(
                children: [
                  Text(
                    'Hello, ${snapshot.data.displayName ?? 'you'}!',
                    style: TextStyle(
                      color: ExpoColors.hvlAccent,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton.icon(
                    icon: Icon(
                      Icons.account_circle,
                      color: Colors.black26,
                    ),
                    label: Text(
                      'Change name',
                      style: TextStyle(color: Colors.black26),
                    ),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: Container(
                              height: 200,
                              width: 400,
                              child: Card(
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: TextField(),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Your votes',
                    style: TextStyle(
                        color: ExpoColors.hvlAccent,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: repository.fetchUserVotes(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: snapshot.data
                              .map((map) => ListTile(
                                  leading: Text(map['weight']),
                                  title: Text(
                                    map['exhibition_id'],
                                  )))
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
