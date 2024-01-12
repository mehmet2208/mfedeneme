import 'package:flutter/material.dart';

//
//
//
TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    //veriyi gizlemeye
    obscureText: isPasswordType,
    //klavye aktif pasif
    enableSuggestions: !isPasswordType,
    //otomatik düzeltme
    autocorrect: !isPasswordType,
    //çubuk rengi
    cursorColor: Colors.white,
    //yazı rengi
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
      //textfield içinin rengi
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          //kenar yuvarlama
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    //klavye tipini ayarlama için kullanılır
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        //E-posta girişi için emailAddress kullanılarak, klavyenin e-posta girişi
        // moduna geçmesi sağlanır ve özel karakterlerin daha erişilebilir olması sağlanır.
        : TextInputType.emailAddress,
  );
}

Container singInUpButton(BuildContext context, bool isLogin, Function onTap) {
  return Container(
    // Container'ın genişliği, ekranın genişliğine eşit olacak şekilde ayarlanır.
    width: MediaQuery.of(context).size.width,
    // yükseklik 50
    height: 50,
    // dört kenarı arasında boşluk bırakılır.
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    // Container'ın köşeleri, 90 piksellik bir yarıçapa sahip bir daire şeklinde yuvarlanır.
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        // Bu Text widget'ı, bir butonun içindeki metni temsil eder.
        // isLogin değişkeninin değerine bağlı olarak, metin ya "Sign In" (Giriş Yap) ya da
        // "Sign Up" (Kayıt Ol) olarak ayarlanır. Yani, kullanıcı kayıtlı ise "Sign In", değilse
        // "Sign Up" metni gösterilecektir.
        isLogin ? 'Sign In' : 'Sign Up',
        style: const TextStyle(
            // Buton içindeki metnin rengi ve stili belirlenir.
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16),
      ),
      style: ButtonStyle(
        // Butonun arka plan rengi ve şekil stilini belirleyen özellikler.
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            // Butona basıldığında alacağı renk.
            return Colors.black26;
          }
          // Basılmadan önceki rengi.
          return Colors.white;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            // Butonun köşelerini yuvarlayan bir daire şeklindeki bir sınır belirlenir.
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      ),
    ),
  );
}
