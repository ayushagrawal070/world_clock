import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDay;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try{
      // make the request to access json
      Response response =
      await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      // print(data);

      // get properties from json
      String datetime = data['datetime'];
      String offsetHr = data['utc_offset'].substring(1, 3);
      String offsetMin = data['utc_offset'].substring(4,6);
      // print(datetime);
      // print(offsetMin);

      // create a date time object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offsetHr)));
      now = now.add(Duration(minutes: int.parse(offsetMin)));

      isDay = now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);

      // time = now.toString();
    }

    catch (e) {
      print('caught error $e');
      time = 'could not get time data';
    }

  }
}
