import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() {
  runApp(location());
}

class location extends StatefulWidget {
  @override
  _locationState createState() => _locationState();
}

class _locationState extends State<location> {
  double? lat;
  double? lon;

  void getlocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      lat = position.latitude;
      lon = position.longitude;
      print(position);
      Response res = await get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=931e8bdeccb205992200128a5f3a3e95'));
      if (res.statusCode == 200) {
        var data = res.body;
        print(data);
        String lon = jsonDecode(data)['coord']['lon'];
      }
    } catch (e) {
      print(e);
      getlocation();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
