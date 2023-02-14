import 'package:flutter/material.dart';
import 'package:vigenesia/splash_screen.dart';
import 'Screens/Login.dart';
import 'package:flutter/services.dart';
// styled and improved by BARKAH HERDYANTO SEJATI 15200065
void main() {
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

      runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black,
          fontFamily: 'Roboto', colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black)),
      home: SplashScreenPage(),
    );
  }
}










//BARKAH HERDYANTO SEJATI//ILMU KOMPUTER//UBSI//15200065