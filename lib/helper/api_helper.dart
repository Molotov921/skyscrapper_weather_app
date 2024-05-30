import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherApi {
  static const String apiKey = '9a7935ffadd84433ac2134743242402';
  static const String baseUrl = 'http://api.weatherapi.com/v1';

  static Future<Map<String, dynamic>> fetchWeatherData(String text) async {
    final response = await http
        .get(Uri.parse('$baseUrl/current.json?key=$apiKey&q=$text&aqi=no'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
