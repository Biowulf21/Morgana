import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'home.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  static String id = "login";
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              // appBar: AppBar(
              //   automaticallyImplyLeading: false,
              // ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Container(
                      child: Placeholder(color: Colors.blue),
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 4),
                        child: Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _emailController,
                      onChanged: (String value) {
                        print('Email is: ${value}');
                      },
                      decoration: InputDecoration(
                          errorText: "error", labelText: "Email"),
                    ),
                    TextField(
                      controller: _passwordController,
                      onChanged: (String value) {
                        print('password is: ${value}');
                      },
                      decoration: InputDecoration(
                          errorText: "error", labelText: "Password"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim());
                        print("logging in");
                      },
                      child: Text("Login"),
                    ),
                    SizedBox(height: 20.0),
                    Divider(),
                    Center(
                      child: Text("or"),
                    ),
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
