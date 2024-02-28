import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/screens/main_screen.dart';
import 'package:weather/utils/location.dart';
import 'package:weather/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData;

  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    if (locationData.latitude == null || locationData.latitude == null) {
      print("konum bigileri alınamadı");
    } else {
      print("latitude" + locationData.latitude.toString());
      print("longitude" + locationData.longitude.toString());
    }
  }

  void getWeatherData() async {
    await getLocationData();

    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();

    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      print("API den sıcaklık veya konum bilgisi boş dönüyor");
    } 

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(weatherData: weatherData),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }

  @override
Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // Arkaya yerleştirilecek resim
              Image.asset(
                'assets/giris.jpeg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Center(
                child: Positioned(
                  child: SpinKitFadingCube(
                    color: Colors.white,
                    size: 50,
                    duration: Duration(milliseconds: 1200),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
