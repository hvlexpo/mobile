import 'package:flutter/material.dart';
import 'package:expo/ui/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expo/data/repositories/user_repository.dart';
import 'package:expo/utils/routes.dart';
import 'package:expo/utils/localization.dart';
class LoginView extends StatefulWidget {
  LoginView({
    Key key,
  }) : super(key: key);

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<LoginView> {
  final _phoneNumberController = TextEditingController();
  final _smsCodeController = TextEditingController();
  final UserRepository userRepository = UserRepository();

  // Needed to access the Scaffold's state outside of the tree
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String verificationId;
  bool codeSent;

  @override
  void initState() {
    super.initState();
    codeSent = false;
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ExpoColors.hvlPrimary,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/hvl_logo.png'),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                controller: _phoneNumberController,
                style: TextStyle(fontSize: 32, color: ExpoColors.hvlAccent),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  helperText: AppLocalizations.of(context).phoneNumber,
                  filled: true,
                  prefix: Text('+47'),
                ),
              ),
            ),
            codeSent
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      controller: _smsCodeController,
                      style:
                          TextStyle(fontSize: 32, color: ExpoColors.hvlAccent),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        helperText: AppLocalizations.of(context).smsCode,
                        filled: true,
                      ),
                    ),
                  )
                : Container(),
            FlatButton.icon(
              icon: Icon(
                Icons.arrow_forward,
                color: ExpoColors.hvlAccent,
              ),
              label: Text(
                codeSent ? AppLocalizations.of(context).verifyCode : AppLocalizations.of(context).sendCode,
                style: TextStyle(color: ExpoColors.hvlAccent),
              ),
              onPressed: () async => codeSent
                  ? await _verifyCode(_smsCodeController.text)
                  : await _verifyPhone('+47${_phoneNumberController.text}'),
            ),
            codeSent
                ? FlatButton.icon(
                    icon: Icon(Icons.refresh, color: ExpoColors.hvlAccent,),
                    label: Text(
                      AppLocalizations.of(context).noCodeReceived,
                      style: TextStyle(color: ExpoColors.hvlAccent),
                    ),
                    onPressed: () => setState(() {
                          codeSent = false;
                        }),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  /// Verifies the given [smsCode] with Firebase using the
  /// [verificationId] received from the ``verifyPhone`` method
  _verifyCode(String smsCode) async {
    final credentials = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await FirebaseAuth.instance
        .signInWithCredential(credentials)
        .then((user) async {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          '${AppLocalizations.of(context).loggedInWith} ${user.phoneNumber}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ExpoColors.hvlAccent,
      ));
      await userRepository.createOrUpdateUser(user).then((_) {
        Navigator.of(context).popAndPushNamed(Routes.home);
      });
    }).catchError((error) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(error.message),
        backgroundColor: Colors.red,
      ));
    });
  }

  /// Verifies the given [phoneNumber] with Firebase, and
  /// either auto-retrieves a code via Google Play or sends
  /// an SMS code to the given [phoneNumber]. Also sets the
  /// [verificationId] for later verification of the SMS code
  Future<void> _verifyPhone(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 5),
      verificationCompleted: (user) async {
        await userRepository.createOrUpdateUser(user).then((_) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.home, (Route<dynamic> route) => false);
        }).catchError((error) {
          print(error);
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(error.message),
            backgroundColor: Colors.red,
          ));
        });
      },
      verificationFailed: (error) {
        print(error);
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(error.message),
          backgroundColor: Colors.red,
        ));
      },
      codeSent: (id, [token]) {
        setState(() {
          verificationId = id;
          codeSent = true;
        });
      },
      codeAutoRetrievalTimeout: (id) {
        setState(() {
          verificationId = id;
          codeSent = true;
        });
      },
    );
  }
}
