import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfe/reusable_widgets/reusable_widget.dart';
import 'package:mfe/view/signin_screen.dart';
import 'package:mfe/view_model/signup_view_model.dart';
import 'package:provider/provider.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey[600]!, // Başlangıç rengi
              Colors.grey[500]!, // Orta renk
              Colors.grey[600]!, // Bitiş rengi
            ],
          ),
        ),
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
          child: Column(children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            reusableTextField(
                "Enter UserName", Icons.person, false, _userNameTextController),
            const SizedBox(
              height: 20,
            ),
            reusableTextField(
                "Enter Email", Icons.person, false, _emailTextController),
            const SizedBox(
              height: 20,
            ),
            reusableTextField(
                "Enter Password", Icons.lock, true, _passwordTextController),
            SizedBox(
              height: 20,
            ),
            _buildSingUpButton(context),

            // singInUpButton(context, false, () {
            //   FirebaseAuth.instance
            //       .createUserWithEmailAndPassword(
            //           email: _emailTextController.text,
            //           password: _passwordTextController.text)
            //       .then((value) {
            //     print("Bu mekana girişşşş yapabiliyorum");
            //     Navigator.push(context,
            //             MaterialPageRoute(builder: (context) => SingInScreen()))
            //         .onError((error, stackTrace) {
            //       print("Error ${error.toString()}");
            //     });
            //   });
            // })
          ]),
        )),
      ),
    );
  }

  Widget _buildSingUpButton(BuildContext context) {
    SingUpViewModel viewModel = Provider.of(context, listen: false);
    return singInUpButton(context, true, () async {
      viewModel.singUp(_emailTextController.text.trim(),
          _passwordTextController.text.trim(), context);
    });
  }
}
