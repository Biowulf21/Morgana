import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  String getCurrentUser() {
    try {
      User? user = FirebaseAuth.instance.currentUser;
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
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              child: Text(loggedInUser!.email.toString()),
            ),
          )
        ],
      ),
    );
  }
}
