import 'package:flutter/material.dart';
import 'package:skyscrapper_weather_app/model/weather_model.dart';

class WeatherInfo extends StatelessWidget {
  final WeatherModel weather;

  const WeatherInfo({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 600,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _buildWeatherDetails(),
            const SizedBox(height: 20),
            _buildLastUpdated(),
            const SizedBox(height: 20),
            _buildRow1(),
            const SizedBox(height: 20),
            _buildRow2(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetails() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black.withOpacity(0.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Image.network(
                weather.conditionIconUrl,
                width: 100,
                height: 100,
              ),
              Text(
                weather.locationName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                weather.text.toUpperCase(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
              Text(
                '${weather.temperatureCelsius}°C',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
              Text(
                'Feels like: ${weather.feelsLikeCelsius}°C | ${weather.feelsLikeFahrenheit}°F',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLastUpdated() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black.withOpacity(0.3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Last updated: ${weather.lastUpdated}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
          Text(
            'Local time: ${weather.localtime}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildInfoCard(
          icon: Icons.air,
          title: "Air Quality",
          info1: 'Wind Degree: ${weather.windDegree}',
          info2: 'Wind MPH: ${weather.windSpeedMph}',
          info3: 'Wind KPH: ${weather.windSpeedKph}',
        ),
        const SizedBox(width: 5),
        _buildInfoCard(
          icon: Icons.wind_power,
          title: "Wind",
          info1: 'Wind Direction: ${weather.windDirection}',
          info2: 'Wind Gust: ${weather.gustMph} mph | ${weather.gustKph} kph',
        ),
      ],
    );
  }

  Widget _buildRow2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildInfoCard(
          icon: Icons.wb_sunny,
          title: "UV Index",
          info1: 'UV Index: ${weather.uvIndex}',
          info2: 'Moderate',
        ),
        const SizedBox(width: 5),
        _buildInfoCard(
          icon: Icons.water_drop_outlined,
          title: "Humidity",
          info1: 'Humidity: ${weather.humidity}',
          info2: 'Visibility KM: ${weather.visibilityKm}',
          info3: 'Visibility Miles: ${weather.visibilityMiles}',
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    String? info1,
    String? info2,
    String? info3,
  }) {
    return Container(
      height: 180,
      width: 180,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Colors.white70,
              ),
              const SizedBox(width: 5),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (info1 != null) ...[
            Text(
              info1,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 10),
          ],
          if (info2 != null) ...[
            Text(
              info2,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 10),
          ],
          if (info3 != null) ...[
            Text(
              info3,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
