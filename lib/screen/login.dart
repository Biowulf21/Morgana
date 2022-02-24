import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'home.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  static String id = "login";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    FlutterSocialButton(
                      onTap: () {},
                      buttonType: ButtonType.google,
                    )
                  ],
                ),
              ),
            );
          } else {
            return Home();
          }
        });
  }
}
