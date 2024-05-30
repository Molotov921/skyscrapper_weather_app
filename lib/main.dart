import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyscrapper_weather_app/provider/weather_provider.dart';
import 'package:skyscrapper_weather_app/views/screens/Homepage/homepage.dart';
import 'package:skyscrapper_weather_app/views/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash_screen',
        routes: {
          '/': (context) => const HomePage(),
          'splash_screen': (context) => const SplashScreen(),
        },
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
