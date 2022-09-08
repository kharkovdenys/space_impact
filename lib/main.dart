import 'package:flutter/material.dart';
import 'package:space_impact/views/screens/menu.dart';
import 'package:space_impact/views/screens/splash.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setFullScreen(true);
    await windowManager.show();
  });
  runApp(const MaterialApp(
      home: SplashScreen(navigateRoute: Menu()),
      debugShowCheckedModeBanner: false));
}
