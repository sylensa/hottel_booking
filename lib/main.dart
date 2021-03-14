import 'package:flutter/material.dart';
import 'package:hottel_booking/pages/home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    theme: new ThemeData(),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/':(context) => Home(),


    },

  ));

}



