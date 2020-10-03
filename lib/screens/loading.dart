import 'package:flutter/material.dart';
import 'package:world_clock/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:connectivity/connectivity.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool internetConnected = true;

  void checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        internetConnected = true;
        setupWorldTime();
      });
    } else {
      setState(() {
        internetConnected = false;
      });
    }
  }

  void setupWorldTime() async {
    WorldTime instance = WorldTime(
        location: 'New Delhi', flag: 'india.png', url: 'Asia/Kolkata');
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDay': instance.isDay,
    });
  }

  @override
  void initState() {
    checkInternet();
    // print(internetConnected);
    super.initState();

    // setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: (!internetConnected)
          ? Center(
            child: Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Internet connection not found',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    width: 120,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    child: GestureDetector(
                      child: Text(
                        'Retry',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        // print('reload intrernet');
                        checkInternet();
                      },
                    ),
                  ),
                ],
              ),
          )
          : Center(
              child: SpinKitPouringHourglass(
                color: Colors.white,
                size: 50.0,
              ),
            ),
    );
  }
}
