import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:provider/provider.dart';
import 'package:test_application/services/google_signin.dart';
import '../models/signup_validation.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);
  static String id = 'signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final validationService = Provider.of<SignUpValidation>(context);
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: const Placeholder(color: Colors.blue),
                  ),
                  TextField(
                    onChanged: (String value) {
                      print('first name is ${value}');
                      validationService.changeName(value);
                      nameController.text =
                          validationService.Name.value!.trim();
                    },
                    decoration: InputDecoration(
                        errorText: validationService.Name.error,
                        labelText: "Name"),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (String value) {
                      validationService.changeEmail(value);
                      emailController.text =
                          validationService.Email.value!.trim();
                    },
                    decoration: InputDecoration(
                        errorText: validationService.Email.error,
                        labelText: "Email"),
                  ),
                  TextField(
                    controller: passwordController,
                    onChanged: (String value) {
                      print('password is: ${value}');
                      validationService.changePassword(value);
                    },
                    decoration: InputDecoration(
                        errorText: validationService.Password.error,
                        labelText: "Password"),
                  ),
                  //

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          print(
                              'email = ${emailController.text}, name = ${emailController.text}, password = ${validationService.Password.value} ');
                          var newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim());

                          print('Signing up');
                          Navigator.pushNamed(context, Home.id);
                        },
                        child: const Text("Submit")),
                  ),

                  const SizedBox(
                      // height:  20.0,
                      ),
                  const Center(
                    child: Text("or"),
                  ),
                  const Divider(),
                  FlutterSocialButton(
                    title: "Sign up with Google",
                    onTap: () async {
                      final googleProvider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      try {
                        await googleProvider.googleLogin();
                      } catch (e) {
                        print('error is ${e}');
                      }
                      print('loggin in google');
                      Navigator.pushNamed(context, Home.id);
                    },
                    buttonType: ButtonType.google,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Home();
        }
      },
    );
  }
}
