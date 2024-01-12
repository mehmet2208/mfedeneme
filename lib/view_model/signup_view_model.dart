import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfe/view/signin_screen.dart';

class SingUpViewModel with ChangeNotifier {
  void singUp(String email, String password, BuildContext context) async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print("Bu mekana girişşşş yapabiliyorum");
      Navigator.push(
              context, MaterialPageRoute(builder: (context) => SingInScreen()))
          .onError((error, stackTrace) {
        print("Error ${error.toString()}");
      });
    });
  }
}
