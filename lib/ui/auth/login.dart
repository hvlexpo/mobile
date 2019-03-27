import 'package:flutter/material.dart';
import 'package:expo/ui/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expo/utils/routes.dart';
import 'package:expo/keys.dart';

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
                codeSent ? 'Verify code' : 'Send code',
                style: TextStyle(color: ExpoColors.hvlAccent),
              ),
              onPressed: () async => codeSent
                  ? _verifyCode(_smsCodeController.text)
                  : _verifyPhone('+47${_phoneNumberController.text}'),
            )
          ],
        ),
      ),
    );
  }

  _verifyCode(String smsCode) async {
    final credentials = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credentials).then((user) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          'Logged in with ${user.phoneNumber}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ExpoColors.hvlAccent,
      ));
    }).catchError((error) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(error.message),
        backgroundColor: Colors.red,
      ));
    });
  }

  Future<void> _verifyPhone(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 5),
      verificationCompleted: (user) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.home, (Route<dynamic> route) => false);
      },
      verificationFailed: (error) {
        print(error);
        Scaffold.of(context).showSnackBar(SnackBar(
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
