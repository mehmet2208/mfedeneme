import 'package:flutter/material.dart';
import 'package:mfe/consts.dart';
import 'package:weather/weather.dart';

class MainViewModel with ChangeNotifier {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? weather;

  MainViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getWeather('Hatay');
    });
  }

  void _getWeather(String cityName) async {
    weather = await _wf.currentWeatherByCityName(cityName);
    notifyListeners();
  }
}
