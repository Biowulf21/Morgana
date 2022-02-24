import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider with ChangeNotifier {
  final google_signin = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await google_signin.signIn();
      if (googleUser == null) {
        return;
      }
      _user = googleUser;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      //TODO: Sign in failed whenever user's google account doesn't exist yet
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('erro is ${e}');
    }
    // await FirebaseAuth.instance
    notifyListeners();
  }

  Future googleSignout() async {
    google_signin.disconnect();
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
