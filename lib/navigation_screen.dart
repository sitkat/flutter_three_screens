import 'package:flutter/material.dart';
import 'package:flutter_three_screens/calculator_screen.dart';
import 'package:flutter_three_screens/data_screen.dart';
import 'package:flutter_three_screens/weather_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _MyAppState();
}

class _MyAppState extends State<NavigationScreen> {
  int _currentIndex = 0;

  final tabs = [
    const DataScreen(),
    const CalculatorScreen(),
    const WeatherScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter-проект'),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xE5E5E5EA),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: 'Данные',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Калькулятор',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),
            label: 'Погода',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
