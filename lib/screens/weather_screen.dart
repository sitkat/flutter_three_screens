import 'package:flutter/material.dart';
import 'package:flutter_three_screens/models/weather_model.dart';
import 'package:flutter_three_screens/services/weather_service.dart';
import 'dart:async';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _weatherService = WeatherService('f69b280ee6e907e5abc6959bc13e36f6');
  Weather? _weather;
  final TextEditingController _changeCity = TextEditingController();
  late Timer _timer;

  _fetchWeather(String cityName) async {
    if (cityName.isEmpty) {
      cityName = 'Saratov';
    }
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  void _updateWeather() {
    _fetchWeather(_changeCity.text);
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather('Saratov');

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _updateWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              maxLines: 1,
              controller: _changeCity,
              decoration: InputDecoration(
                labelText: 'Город',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Text(
            //   _weather?.cityName ?? "Загрузка...",
            //   style: const TextStyle(
            //     fontSize: 20,
            //   ),
            // ),
            // const SizedBox(height: 5),
            Text(
              '${_weather?.temp.round()}°C',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  _fetchWeather(_changeCity.text);
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide.none,
                    )),
                    fixedSize: MaterialStateProperty.all<Size>(
                        const Size(double.maxFinite, 30))),
                child: const Text('Загрузить данные')),
          ],
        ),
      ),
    );
  }
}
