import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyscrapper_weather_app/provider/weather_provider.dart';
import 'package:skyscrapper_weather_app/views/screens/Detail/info_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/weather_app.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text(
                'Weather App',
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              expandedHeight: 100,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverToBoxAdapter(
                child: TextField(
                  controller: searchController,
                  style: const TextStyle(color: Colors.white70, fontSize: 20),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Search for a City/Country',
                    hintStyle: const TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white70),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search, color: Colors.white70),
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        Provider.of<WeatherProvider>(context, listen: false)
                            .fetchWeatherData(searchController.text);
                        Provider.of<WeatherProvider>(context, listen: false)
                            .saveLocation(searchController.text);
                        Provider.of<WeatherProvider>(context, listen: false)
                            .loadSavedLocations();
                      },
                    ),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Consumer<WeatherProvider>(
                builder: (context, weatherProvider, _) {
                  return AnimatedBuilder(
                    animation: weatherProvider,
                    builder: (context, child) {
                      return weatherProvider.weather == null
                          ? const Center(
                              child: Text(
                                "No data available. Search for a location.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                            )
                          : WeatherInfo(weather: weatherProvider.weather!);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
