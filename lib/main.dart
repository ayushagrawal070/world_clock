import 'package:flutter/material.dart';
import 'package:world_clock/screens/loading.dart';
import 'package:world_clock/screens/home.dart';
import 'package:world_clock/screens/chose_location.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/location': (context) => ChooseLocation(),
  },
));
