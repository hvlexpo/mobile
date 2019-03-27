import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Card(
            child: Center(child: _userText()),
          ),
        ],
      ),
    );
  }

  Widget _userText() {
    return FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return Column(
            children: <Widget>[
              Text(snapshot.data.phoneNumber),
            ],
          );
        } else return Text('Loading..');
      },
    );
  }
}
