import 'package:flutter/material.dart';
import 'package:expo/ui/theme/theme.dart';
import 'package:expo/utils/localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:built_collection/built_collection.dart';
import 'package:expo/ui/exhibitions/exhibition_tile.dart';
import 'package:expo/ui/exhibitions/exhibition_default_view.dart';
import 'package:expo/data/models/exhibition_model.dart';
import 'package:expo/data/models/user_model.dart';
import 'package:expo/data/repositories/user_repository.dart';
import 'package:expo/data/repositories/exhibition_repository.dart';
import 'package:expo/utils/localization.dart';

class ProfileView extends StatelessWidget {
  final userRepository = UserRepository();
  final exhibitionRepository = ExhibitionRepository();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserEntity>(
      future: userRepository.fetchCurrentUser(),
      builder: (context, userSnapshot) {
        if (userSnapshot.hasData) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            child: Container(
              child: Column(
                children: [
                  Text(
                    'Hello, ${userSnapshot.data.displayName ?? 'you'}!',
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
                      AppLocalizations.of(context).changeName,
                      style: TextStyle(color: Colors.black26),
                    ),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: Container(
                              height: 200,
                              width: 350,
                              child: Card(
                                color: ExpoColors.hvlPrimary,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextField(
                                        controller: nameController,
                                        style: TextStyle(
                                            fontSize: 32,
                                            color: ExpoColors.hvlAccent),
                                        decoration: InputDecoration(
                                          filled: true,
                                          helperText: AppLocalizations.of(context).yourName
                                        ),
                                      ),
                                      FlatButton.icon(
                                        icon: Icon(Icons.check, color: ExpoColors.hvlAccent,),
                                        label: Text(AppLocalizations.of(context).submit, style: TextStyle(
                                          color: ExpoColors.hvlAccent,
                                        ),),
                                        onPressed: () async {
                                          final user = await FirebaseAuth.instance.currentUser();
                                          final info = UserUpdateInfo();
                                          info.displayName = nameController.text;
                                          await user.updateProfile(info);
                                          await userRepository.updateUser(user, name: info.displayName);
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
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
                    AppLocalizations.of(context).yourVotes,
                    style: TextStyle(
                        color: ExpoColors.hvlAccent,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: userRepository.fetchUserVotes(),
                    builder: (context, voteSnapshot) {
                      if (voteSnapshot.hasData) {
                        return Expanded(
                          child: ListView(
                            children: voteSnapshot.data
                                .map((map) => _buildVoteHistory(
                                    map['exhibition_id'], userSnapshot.data.id))
                                .toList(),
                          ),
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

  Widget _buildVoteHistory(String exhibitionId, String userId) {
    return FutureBuilder<ExhibitionEntity>(
      future: exhibitionRepository.fetchExhibitionById(exhibitionId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.access_time),
              title: Text(
                snapshot.data.displayName,
              ),
              subtitle: Center(child: _buildUserVotes(snapshot.data)),
              onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ExhibitionDefaultView(snapshot.data, votable: true),
                    ),
                  ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildUserVotes(ExhibitionEntity exhibition) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: userRepository.fetchUserVotes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          int weight;
          final vote = snapshot.data.firstWhere(
              (i) => i['exhibition_id'] == exhibition.id,
              orElse: () => {'weight': '0'});
          weight = int.parse(vote['weight']);
          return weight != 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context).yourVote,
                      style: TextStyle(color: Colors.black26),
                    ),
                    Row(
                        children: [1, 2, 3, 4, 5].map((index) {
                      return Icon(
                        Icons.star,
                        color:
                            (index <= weight) ? Colors.yellow : Colors.black12,
                        size: (index <= weight) ? 16 : 14,
                      );
                    }).toList()),
                  ],
                )
              : Container();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
