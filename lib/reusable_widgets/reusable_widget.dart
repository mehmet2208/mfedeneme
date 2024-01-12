import 'package:flutter/material.dart';

//
//
//
TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    //çubuk rengi
    cursorColor: Colors.white,
    //yaz rengi
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    //icon tasarımı
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white30,
      ),
      labelText: text,
      //otomatik text tasarımı
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      //texti içinde tutma
      floatingLabelBehavior: FloatingLabelBehavior.never,
      //textfield rengi
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container singInUpButton(BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? 'Sign In' : 'Sign Up',
        style: const TextStyle(
            //button içi yazı rengi ve stili
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16),
      ),
      style: ButtonStyle(
          //button rengi stili
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              //basıldığında aldıgı renk
              return Colors.black26;
            }
            //basılmadan önceki rengi
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}
