import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfe/view/signin_screen.dart';

class SingUpViewModel with ChangeNotifier {
  // Kullanıcı kayıt işlemini gerçekleştiren metod.
  void singUp(String email, String password, BuildContext context) async {
    // FirebaseAuth.instance, Firebase Authentication servisine erişimi sağlamak için kullanılan bir nesnedir.
    // createUserWithEmailAndPassword metodu, e-posta ve şifre kullanarak yeni bir kullanıcı hesabı oluşturur.
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      // Kayıt işlemi başarılıysa, bu blok çalışır.
      print("Bu mekana girişşşş yapabiliyorum");
      // Yeni kullanıcı oluşturulduktan sonra, kullanıcıyı giriş ekranına yönlendiren Navigator işlemi.
      Navigator.push(
              context, MaterialPageRoute(builder: (context) => SingInScreen()))
          // Navigator işlemi bir hata oluşursa bu onError bloğu çalışır.
          .onError((error, stackTrace) {
        print("Error ${error.toString()}");
      });
    });
  }
}
