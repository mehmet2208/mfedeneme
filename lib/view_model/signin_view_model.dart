import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfe/view/home_screen.dart';
import 'package:mfe/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class SignInViewModel with ChangeNotifier {
  //Firebase Authentication servisi ile etkileşimde bulunup kayıt giriş şifre sıfırlama için kullanılır
  FirebaseAuth _auth = FirebaseAuth.instance;

  void signIn(String email, String password, BuildContext context) async {
    try {
      // Giriş yapılıyor, bu durumu kontrol etmek için bir print ifadesi.
      print("Giriş yapıyorum");

      // signInWithEmailAndPassword metodu, kullanıcının e-posta ve şifre ile giriş yapmasını sağlar.
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Giriş başarılı olduğunda, kullanıcıyı HomeScreen'e yönlendiren Navigator işlemi.
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => MainViewModel(),
            child: HomeScreen(),
          ),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      // FirebaseAuthException: FirebaseAuth ile ilgili özel durumlar için bir hata yakalama bloğu.
      // Bu blok, kullanıcının bulunamadığı veya yanlış şifre girdiği durumları ele alır.
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        // Diğer hataları yazdırmak için genel bir durum.
        print('Error during sign in: ${e.message}');
      }
    } catch (e) {
      // Diğer tüm hataları yakalamak için genel bir catch bloğu.
      print('Error: $e');
    }
  }
}
//uygulamanın temel yapısını sağlar ve Firebase kullanarak kullanıcının giriş durumuna bağlı 
//olarak farklı ekranlara yönlendirilmesini sağlar. ChangeNotifierProvider kullanılarak, 
//view modelleri ile uygulama içinde durum yönetimi sağlanır. Bu kod, uygulama başlatıldığında
// kullanıcının durumuna göre ilk görünen sayfayı belirler.