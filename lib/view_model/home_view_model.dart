import 'package:flutter/material.dart';
import 'package:mfe/consts.dart';
import 'package:weather/weather.dart';

class MainViewModel with ChangeNotifier {
  //WeatherFactory, hava durumu bilgilerini sağlamak için kullanılan bir sınıftır.
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? weather;
// constructor içinde yer alıyor. sınıfın oluşturulduğu anın hemen ardından çalışacak bir işlemi başlatıyor.
  MainViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getWeather('Hatay');
    });
  }

  void _getWeather(String cityName) async {
    // await Bu durumda, hava durumu bilgisi alındıktan sonra devam edilir.
    weather = await _wf.currentWeatherByCityName(cityName);
    //_getWeather metodunun çağrılması sonrasında hava durumu bilgisinde bir değişiklik
    //olduğunda, bu değişikliği dinleyen widgetlara bildirir.
    notifyListeners();
  }
}
//Bu sayfa, hava durumu bilgisini yönetmek için kullanılır. 
//Hava durumu bilgisi güncellendiğinde widget otomatik olarak güncellenir. 
