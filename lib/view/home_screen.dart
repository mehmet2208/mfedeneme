import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mfe/view/signin_screen.dart';
import 'package:mfe/view_model/home_view_model.dart';
import 'package:mfe/view_model/signin_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override

  //body özelliği ise Consumer widget'i ile dolduruluyor. Consumer widget'i, bir değişiklik
  //dinleyicisi olarak kullanılarak, belirli bir veri modeli
  //üzerindeki değişiklikleri algılar ve sadece bu değişikliklerin olduğu
  //durumlarda ilgili arayüzü güncellemeye izin verir.
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBarUI(context),
        body: Consumer<MainViewModel>(
          builder: (context, viewModel, child) => _buildUI(
            context,
            viewModel,
          ),
        ));
  }

  AppBar _appBarUI(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[600],
      title: const Text('Weather App'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.black,
          ),
          onPressed: () {
            // Konsola çıkış mesajını yazdırır.
            print("Ben bu mekandan çıkışşşş yapıyorum");
            // FirebaseAuth üzerinden çıkış işlemi gerçekleştirilir.
            FirebaseAuth.instance.signOut().then((value) {
              // Çıkış işlemi başarılı olduğunda yeni ekran açılır.
              Navigator.push(
                context,
                MaterialPageRoute(
                  // ChangeNotifierProvider ile yeni bir SignInViewModel oluşturulur.
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => SignInViewModel(),
                    // Oluşturulan SignInViewModel ile SingInScreen açılır.
                    child: SingInScreen(),
                  ),
                ),
              );
            });
          },
        ),
      ],
    );
  }
}

Widget _buildUI(BuildContext context, MainViewModel viewModel) {
  // Eğer hava durumu bilgisi henüz alınmamışsa, kullanıcıya bekleme göstergesi (CircularProgressIndicator) gösterilir.
  if (viewModel.weather == null) {
    return const Center(
      // veri alımı veya işleme sırasında kullanıcının
      // beklemesini sağlamak ve uygulamanın tepkisiz gözükmesini önlemek amacıyla kullanılır.
      child: CircularProgressIndicator(),
    );
  }
  // Eğer hava durumu bilgisi mevcutsa, ana ekranın tasarımını oluşturan Scaffold widget'ı döndürülür.
  return Scaffold(
    body: Container(
      // Container'ın genişliği ve yüksekliği, ekranın genişliği ve yüksekliğine eşit olacak şekilde ayarlanır.
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // Gradient renk geçişi için kullanılan renkler.
            Colors.grey[600]!, // Başlangıç rengi
            Colors.grey[500]!, // Orta renk
            Colors.grey[600]!, // Bitiş rengi
          ],
        ),
      ),
      // Container içindeki elemanları dikey bir sütun halinde düzenler.
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(context, viewModel),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.08,
          ),
          _dateTimeInfo(context, viewModel),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          _weatherIcon(context, viewModel),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          _currentTemp(context, viewModel),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          _extraInfo(context, viewModel),
        ],
      ),
    ),
  );
}

Widget _locationHeader(BuildContext context, MainViewModel viewModel) {
  // hava durumu bilgisindeki alan adı (location) gösterilir.
  return Text(
    // Hava durumu bilgisindeki alan adı, null değilse kullanılır; null ise boş bir string kullanılır.
    viewModel.weather?.areaName ?? "",
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget _dateTimeInfo(BuildContext context, MainViewModel viewModel) {
  // Hava durumu bilgisindeki tarih ve saat bilgisi alınır.
  DateTime now = viewModel.weather!.date!;

  return Column(
    children: [
      Text(
        //örneğin: 6:30 PM.
        DateFormat("h:mm a").format(now),
        style: const TextStyle(
          fontSize: 35,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      // Tarih ve gün bilgisi için bir satır oluşturulur.
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            // örneğin: Monday.
            DateFormat("EEEE").format(now),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            // örneğin: 15-01-2022.
            "  ${DateFormat("dd-MM-yyyy").format(now)}",
            style: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _weatherIcon(BuildContext context, MainViewModel viewModel) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: MediaQuery.sizeOf(context).height * 0.2,
        decoration: BoxDecoration(
          image: DecorationImage(
            // Resim, bir ağ adresinden (URL) alınır.
            image: NetworkImage(
              "http://openweathermap.org/img/wn/${viewModel.weather?.weatherIcon}@4x.png",
            ),
          ),
        ),
      ),
      // Hava durumu açıklamasını içeren bir metin widget'ı oluşturulur.
      Text(
        // Hava durumu açıklaması, null değilse kullanılır; null ise boş bir string kullanılır.
        viewModel.weather?.weatherDescription ?? "",
        // Metin stili özellikleri belirlenir.
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    ],
  );
}

Widget _currentTemp(BuildContext context, MainViewModel viewModel) {
  return Text(
    // Mevcut sıcaklık değeri, null değilse kullanılır; null ise boş bir string kullanılır.
    "${viewModel.weather?.temperature?.celsius?.toStringAsFixed(0)} °C",
    style: const TextStyle(
      color: Colors.black,
      fontSize: 60,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget _extraInfo(BuildContext context, MainViewModel viewModel) {
  return Container(
    width: MediaQuery.sizeOf(context).width * 0.8,
    height: MediaQuery.sizeOf(context).height * 0.15,
    decoration: BoxDecoration(
      color: Colors.black54,
      borderRadius: BorderRadius.circular(20),
    ),
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              // Maksimum sıcaklık değeri, null değilse metin olarak kullanılır; null ise boş bir string gösterilir.
              "Max: ${viewModel.weather?.tempMax?.celsius?.toStringAsFixed(0)} °C",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Text(
              // Minimum sıcaklık değeri, null değilse metin olarak kullanılır; null ise boş bir string gösterilir.
              "Min: ${viewModel.weather?.tempMin?.celsius?.toStringAsFixed(0)} °C",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              // Rüzgar hızı değeri, null değilse metin olarak kullanılır; null ise boş bir string gösterilir.
              "Wind: ${viewModel.weather?.windSpeed?.toStringAsFixed(0)} m/s",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Text(
              // Nem değeri, null değilse metin olarak kullanılır; null ise boş bir string gösterilir.
              "Humidity: ${viewModel.weather?.humidity?.toStringAsFixed(0)} %",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            )
          ],
        )
      ],
    ),
  );
}

/*
      body: Center(
        child: ElevatedButton(
          child: Text("Logout"),
          onPressed: () {
            print("Ben bu mekandan çıkışşşş yapıyorum");
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SingInScreen()));
            });
          },
        ),
      ),
*/
