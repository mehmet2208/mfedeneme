import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mfe/screens/home_screen.dart';
import 'package:mfe/screens/signin_screen.dart';
import 'package:mfe/view_model/home_view_model.dart';
import 'package:mfe/view_model/signin_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  String? userId = FirebaseAuth.instance.currentUser?.uid;

  bool _isSignedIn() {
    if (userId == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
          create: (context) => SignInViewModel(),
          child: _isSignedIn()
              ? ChangeNotifierProvider(
                  create: (context) => MainViewModel(),
                  child: HomeScreen(),
                )
              : ChangeNotifierProvider(
                  create: (context) => SignInViewModel(),
                  child: SingInScreen(),
                )),
    );
  }
}
