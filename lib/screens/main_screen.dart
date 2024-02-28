import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/utils/weather.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.weatherData});
  final WeatherData weatherData;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int temperature;
  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;
  late String city;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature.round();
      city = weatherData.city;
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(image: backgroundImage, fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              child: weatherDisplayIcon,
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "$temperature°",
                style: TextStyle(
                    fontSize: 80, color: Colors.white, letterSpacing: -7),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                city,
                style: TextStyle(
                    fontSize: 50, color: Colors.white, letterSpacing: -5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
