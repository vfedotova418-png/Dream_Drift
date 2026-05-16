import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dream_screen.dart';

class MenuScreen extends StatelessWidget {
  final SharedPreferences prefs;
  const MenuScreen({
    super.key,
    required this.prefs,
  });

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.water_drop_rounded,
                color: const Color(
                  0x88AEEEEE,
                ).withOpacity(0.7),
                size: 56,
              ),
              const SizedBox(height: 20),
              Text(
                'Dream Drift',
                style: TextStyle(
                  color: Colors.white.withOpacity(
                    0.85,
                  ),
                  fontSize: 28,
                  fontWeight: FontWeight.w200,
                  letterSpacing: 8,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'a soothing ambient experience',
                style: TextStyle(
                  color: Colors.white.withOpacity(
                    0.4,
                  ),
                  fontSize: 12,
                  letterSpacing: 4,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 48),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, _, _) =>
                          DreamScreen(
                            prefs: prefs,
                          ),
                      transitionsBuilder:
                          (
                            _,
                            animation,
                            _,
                            child,
                          ) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                      transitionDuration:
                          const Duration(
                            milliseconds: 800,
                          ),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 16,
                      ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(
                        0x88AEEEEE,
                      ).withOpacity(0.5),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(
                          0x88AEEEEE,
                        ).withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Text(
                    'Begin',
                    style: TextStyle(
                      color: Colors.white
                          .withOpacity(0.9),
                      fontSize: 18,
                      letterSpacing: 6,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
