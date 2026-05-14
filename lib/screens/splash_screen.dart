import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'menu_screen.dart';

class SplashScreen extends StatefulWidget {
  final SharedPreferences prefs;
  const SplashScreen({
    super.key,
    required this.prefs,
  });

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeIn = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, _, _) =>
                  MenuScreen(prefs: widget.prefs),
              transitionsBuilder:
                  (_, animation, _, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
              transitionDuration: const Duration(
                milliseconds: 800,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A0E27),
              Color(0xFF111B3D),
              Color(0xFF0F3460),
              Color(0xFF0A1628),
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeIn,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.water_drop_rounded,
                  color: const Color(
                    0x88AEEEEE,
                  ).withOpacity(0.8),
                  size: 64,
                ),
                const SizedBox(height: 24),
                Text(
                  'Dream Drift',
                  style: TextStyle(
                    color: Colors.white
                        .withOpacity(0.9),
                    fontSize: 32,
                    fontWeight: FontWeight.w200,
                    letterSpacing: 8,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'drift away...',
                  style: TextStyle(
                    color: Colors.white
                        .withOpacity(0.4),
                    fontSize: 14,
                    letterSpacing: 6,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
