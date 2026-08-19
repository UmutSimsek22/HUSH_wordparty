import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/game_provider.dart';
import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const HushApp());
}

class HushApp extends StatelessWidget {
  const HushApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameProvider()
        ..loadCards()
        ..setupDefaultTeams(),
      child: MaterialApp(
        title: 'HUSH!',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF0F141C),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF00A8FF),
            secondary: Color(0xFFFFC048),
            surface: Color(0xFF161E2B),
            onPrimary: Colors.white,
            onSecondary: Color(0xFF121820),
            onSurface: Color(0xFFF8FAFC),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          fontFamily: 'Roboto',
        ),
        builder: (context, child) {
          // Wrap in a mobile aspect ratio frame on wide desktop screens
          return Container(
            color: const Color(0xFF080C12),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    child: child ?? const SizedBox(),
                  ),
                ),
              ),
            ),
          );
        },
        home: const WelcomeScreen(),
      ),
    );
  }
}
