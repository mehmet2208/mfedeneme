import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfe/view/home_screen.dart';
import 'package:mfe/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class SignInViewModel with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  void signIn(String email, String password, BuildContext context) async {
    try {
      print("Giriş yapıyorum");
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Successful login, navigate to HomeScreen
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => MainViewModel(),
              child: HomeScreen(),
            ),
          ),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('Error during sign in: ${e.message}');
      }
    } catch (e) {
      // Handle other exceptions
      print('Error: $e');
    }
  }
}
