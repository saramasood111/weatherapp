import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/network.dart';
import 'dart:convert';
import 'LocationScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Step1 : change compileSdkVersion 31 in build.gradle directory in android->App->build,gradle
//step2: re run the app and add permssion line of code
//Step3,Avd that support google play

class myapp extends StatefulWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  _myappState createState() => _myappState();
}

class _myappState extends State<myapp> {
  Position? position;
  double? lat;
  double? lon;

  void getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    permission = await Geolocator.requestPermission();

    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    lat = position!.latitude;
    lon = position!.longitude;
    networkhelper helper = networkhelper(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?units=metric&lat=$lat&lon=$lon&appid=931e8bdeccb205992200128a5f3a3e95'));

    var weatherdata = await helper.getdata();
    print(weatherdata);

    // double temp = weatherdata['main']['temp'];
    // int condition =  weatherdata['weather'][0]['id'];
    // String city = weatherdata['name'];
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherdata);
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: SpinKitDoubleBounce(color: Colors.grey, size: 40)),
      ),
    );
  }
}
