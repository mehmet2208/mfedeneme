import 'package:flutter/material.dart';
import 'package:mfe/reusable_widgets/reusable_widget.dart';
import 'package:mfe/view/signup_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:mfe/view_model/signin_view_model.dart';
import 'package:mfe/view_model/signup_view_model.dart';
import 'package:provider/provider.dart';

class SingInScreen extends StatelessWidget {
  SingInScreen({super.key});

  final TextEditingController _passwordTextController = TextEditingController();

  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              //background rengi
              Colors.grey[600]!, // Başlangıç rengi
              Colors.grey[500]!, // Orta renk
              Colors.grey[600]!, // Bitiş rengi
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                MyColumnWithLottie(),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("ENTER USERNAME", Icons.person, false,
                    _emailTextController),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("ENTER PASSWORD", Icons.lock, true,
                    _passwordTextController),
                const SizedBox(
                  height: 30,
                ),
                _buildSignInButton(context),
                singUpOption(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    SignInViewModel viewModel = Provider.of(context, listen: false);
    return singInUpButton(context, true, () async {
      viewModel.signIn(_emailTextController.text.trim(),
          _passwordTextController.text.trim(), context);
    });
  }

  Row singUpOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                          create: (context) => SingUpViewModel(),
                          child: SingUpScreen(),
                        )));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

class MyColumnWithLottie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Lottie widget'ını ekleyin ve animasyonunuzun yolunu belirtin.
        Lottie.asset('assets/animation/thunder.json', width: 200, height: 200),
        SizedBox(height: 20),
      ],
    );
  }
}













/*
 Widget _buildLoginButton(BuildContext context) {
    LoginViewModel viewModel = Provider.of(
      context,
      listen: false,
    );
    return ElevatedButton(
      child: Text("Giriş Yap"),
      onPressed: () {
        viewModel.login(
          context,
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      },
    );
  }
*/