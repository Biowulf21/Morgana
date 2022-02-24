import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application/models/signup_validation.dart';
import 'package:test_application/screen/home.dart';
import 'package:test_application/screen/login.dart';
import 'package:test_application/screen/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_application/screen/welcome.dart';
import 'package:test_application/services/google_signin.dart';
//import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<GoogleSignInProvider>(
        create: (_) => GoogleSignInProvider(),
      ),
      ChangeNotifierProvider<SignUpValidation>(
        create: (_) => SignUpValidation(),
      ),
    ], child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
    print('Done Setting Up');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          Login.id: (context) => Login(),
          SignUp.id: (context) => SignUp(),
          Home.id: (context) => Home()
        });
  }
}
