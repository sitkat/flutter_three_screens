import 'dart:convert';

import 'package:flutter_three_screens/models/weather_model.dart';
import 'package:http/http.dart';

class WeatherService {
  static const url = 'http://api.openweathermap.org/data/2.5/weather';

  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response =
        await get(Uri.parse('$url?q=$cityName&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Ошибка получения погоды');
    }
  }
}
