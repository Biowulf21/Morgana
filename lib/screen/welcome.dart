import 'package:flutter/material.dart';
import 'package:test_application/screen/login.dart';
import 'package:test_application/screen/signup.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static String id = "welcome";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                color: Colors.transparent,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Login.id);
                },
                child: Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignUp.id);
                },
                child: Text('SignUp'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
