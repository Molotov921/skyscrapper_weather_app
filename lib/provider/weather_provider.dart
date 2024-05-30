import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skyscrapper_weather_app/helper/api_helper.dart';
import 'package:skyscrapper_weather_app/model/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? _weather;
  bool _isVisible = true;
  final List<String> _savedLocations = [];

  WeatherModel? get weather => _weather;

  bool get isVisible => _isVisible;

  List<String> get savedLocations => _savedLocations;

  Future<void> fetchWeatherData(String text) async {
    try {
      final decodedData = await WeatherApi.fetchWeatherData(text);
      _weather = WeatherModel.fromJson(decodedData);
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to load weather data: $error');
    }
  }

  Future<void> saveLocation(String location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _savedLocations.add(location);

    await prefs.setStringList('savedLocations', _savedLocations);

    notifyListeners();
  }

  Future<void> loadSavedLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? savedLocations = prefs.getStringList('savedLocations');

    if (savedLocations != null) {
      _savedLocations.clear();
      _savedLocations.addAll(savedLocations);
    }

    notifyListeners();
  }

  void startBlinking() {
    Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {
        _isVisible = !_isVisible;
        notifyListeners();
      },
    );
  }
}
