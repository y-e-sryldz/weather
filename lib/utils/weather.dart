import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'location.dart';

const apiKey = "special";

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  WeatherData({required this.locationData,this.city=''});

  LocationHelper locationData;
  double currentTemperature = 0.0;
  int currentCondition = 0;
  String city;

  Future<void> getCurrentTemperature() async {
    http.Response response = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=$apiKey&units=metric"),
    );

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);
      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        city = currentWeather['name'];
      } catch (e) {
        print(e);
      }
    } else {
      print("API'den değer gelmiyor");
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    //hava durumu
    if (currentCondition < 600) {
      return WeatherDisplayData(
          weatherIcon: Icon(
            FontAwesomeIcons.cloud,
            size: 75,
            color: Colors.white,
          ),
          weatherImage: AssetImage('assets/bulutlu.jpeg'));
    } else {
      //hava iyi
      //gece gündüz kontrolü
      var now = new DateTime.now();
      if (now.hour >= 19) {
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.moon,
              size: 75,
              color: Colors.white,
            ),
            weatherImage: AssetImage('assets/gece.jpeg'));
      } else {
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.sun,
              size: 75,
              color: Colors.white,
            ),
            weatherImage: AssetImage('assets/gunesli.jpeg'));
      }
    }
  }
}
