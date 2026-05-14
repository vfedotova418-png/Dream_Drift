import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs =
      await SharedPreferences.getInstance();
  runApp(DreamDriftApp(prefs: prefs));
}

class DreamDriftApp extends StatelessWidget {
  final SharedPreferences prefs;
  const DreamDriftApp({
    super.key,
    required this.prefs,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dream Drift',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor:
            Colors.transparent,
      ),
      home: SplashScreen(prefs: prefs),
    );
  }
}
