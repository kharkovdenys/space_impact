import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget splash = SplashScreenView(
      navigateRoute: const Menu(),
      duration: 3000,
      imageSize: 350,
      imageSrc: "assets/images/Logo.png",
      backgroundColor: Colors.black,
    );

    return MaterialApp(home: splash, debugShowCheckedModeBanner: false);
  }
}
