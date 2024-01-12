import 'package:flutter/material.dart';
import 'package:mfe/reusable_widgets/reusable_widget.dart';
import 'package:mfe/view_model/signup_view_model.dart';
import 'package:provider/provider.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  // TextEditingController sınıfından türetilen nesnelerle metin giriş alanlarını kontrol etmek amacıyla kullanılır.
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar'ın arka planını şeffaf hale getirir.
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors
            .transparent, // AppBar'ın arka plan rengi şeffaf olarak ayarlanır.
        elevation: 0, // AppBar'ın gölge efekti kaldırılır.
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        // MediaQuery.of(context).size.width ifadesi, MediaQuery sınıfını kullanarak cihazın ekran
        // boyutlarına erişir. size özelliği, ekranın genişliği ve yüksekliğini içeren bir Size
        // nesnesini temsil eder. Bu nesnenin width özelliği, ekranın genişliğini ifade eder.
        width: MediaQuery.of(context).size.width,
        // MediaQuery.of(context).size.height ifadesi, cihazın ekran yüksekliğini temsil eder.
        height: MediaQuery.of(context).size.height,
        // Container'ın dekorasyonu ayarlanır. Bu durumda, arka plan rengi ve gradient renkleri belirlenir.
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey[600]!, // Başlangıç rengi
              Colors.grey[500]!, // Orta renk
              Colors.grey[600]!, // Bitiş rengi
            ],
          ),
        ),
        // Dikey yönde sınırsız bir şekilde kaydırmak için kullanılır.
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter UserName", Icons.person, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Enter Email", Icons.person, false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock, true,
                    _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                _buildSingUpButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // SingUpViewModel almayı amaçlar. Bu obje, ChangeNotifier sınıfından türetilmiş bir sınıftır
  // metodu ve dinleyiciyi bulundurarak bir ViewModel görevi görür.
  Widget _buildSingUpButton(BuildContext context) {
    SingUpViewModel viewModel = Provider.of(context, listen: false);
    return singInUpButton(context, true, () async {
      viewModel.singUp(_emailTextController.text.trim(),
          _passwordTextController.text.trim(), context);
    });
  }
}
