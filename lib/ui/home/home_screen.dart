import 'dart:async';
import 'package:expo/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:expo/ui/theme/theme.dart';
import 'package:expo/ui/profile/profile_view.dart';
import 'package:expo/ui/exhibitions/exhibition_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:expo/utils/localization.dart';

class HomeView extends StatefulWidget {
  static final String route = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeView> {
  int currentPage;
  StreamSubscription authListener;

  @override
  void initState() {
    super.initState();
    authListener = FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      if (user != null) {
      } else {
        Navigator.of(context).popAndPushNamed(Routes.login);
      }
    });
    currentPage = 1;
  }

  @override
  void dispose() {
    authListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/hvl_logo.png',
          width: 25,
          height: 25,
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.language, color: Colors.black26,),
            onPressed: () async =>
                Localizations.localeOf(context).countryCode != 'no'
                    ? AppLocalizations.load(Locale('en'))
                    : AppLocalizations.load(Locale('no')),
          ),
        ],
      ),
      body: _getPage(currentPage),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 50),
            child: IconButton(
              tooltip: AppLocalizations.of(context).dashboard,
              icon: Icon(
                Icons.dashboard,
                color: currentPage == 0
                    ? ExpoColors.hvlAccent
                    : ExpoColors.hvlPrimary,
              ),
              onPressed: currentPage == 0
                  ? null
                  : () => setState(() {
                        currentPage = 0;
                      }),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 50),
            child: IconButton(
              tooltip: AppLocalizations.of(context).user,
              icon: Icon(
                GroovinMaterialIcons.account_settings,
                color: currentPage == 1
                    ? ExpoColors.hvlAccent
                    : ExpoColors.hvlPrimary,
              ),
              onPressed: currentPage == 1
                  ? null
                  : () => setState(() {
                        currentPage = 1;
                      }),
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, Routes.scan),
        elevation: 4.0,
        icon: Icon(Icons.nfc),
        backgroundColor: ExpoColors.hvlAccent,
        foregroundColor: Colors.white,
        label: Text('Scan'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return ExhibitionList();
        break;

      case 1:
        return ProfileView();
        break;
      default:
        return Text('Error');
    }
  }
}
