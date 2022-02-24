import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:test_application/screen/login.dart';
import 'package:test_application/screen/signup.dart';
import 'package:test_application/services/google_signin.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  static String id = 'home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userEmail = '';
  final _auth = FirebaseAuth.instance;

  User? loggedInUser;
  User? user = FirebaseAuth.instance.currentUser;

  String getCurrentUser() {
    try {
      loggedInUser = user;
      return user!.email.toString();
    } catch (e) {
      print(e);
      return "";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userEmail = getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('connection waiting');
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            print('has data');
            return loggedInWidget(user: user, loggedInUser: loggedInUser);
          } else if (snapshot.hasError) {
            print('has errror');
            return Center(
              child: Text("Something went wrong."),
            );
          } else {
            print('returning login page');
            return Login();
          }
        });
  }
}

class loggedInWidget extends StatelessWidget {
  const loggedInWidget({
    Key? key,
    required this.user,
    required this.loggedInUser,
  }) : super(key: key);

  final User? user;
  final User? loggedInUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Container(),
          ),
          Center(
            child: CircleAvatar(
              radius: 40.0,
              backgroundImage: NetworkImage(user!.photoURL!),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Column(
              children: [
                Text('Name: ${loggedInUser!.displayName}'),
                Text('Email: ${loggedInUser!.email}'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final provider = await Provider.of<GoogleSignInProvider>(
                    context,
                    listen: false);
                provider.googleSignout;
                print('logging out');
              },
              child: Text("Logout"),
            ),
          ),
        ],
      ),
    );
  }
}
