import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:hush_party/providers/game_provider.dart';
import 'package:hush_party/screens/welcome_screen.dart';

void main() {
  testWidgets('HUSH! WelcomeScreen renders logo and menu options', (WidgetTester tester) async {
    final provider = GameProvider()..setupDefaultTeams();

    await tester.pumpWidget(
      ChangeNotifierProvider<GameProvider>.value(
        value: provider,
        child: const MaterialApp(
          home: WelcomeScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('HUSH!'), findsOneWidget);
    expect(find.text('OYUNA BAŞLA'), findsOneWidget);
    expect(find.text('NASIL OYNANIR?'), findsOneWidget);
    expect(find.text('AYARLAR'), findsOneWidget);
    expect(find.text('KÜNYE (CREDITS)'), findsOneWidget);
    expect(find.text('ÇIKIŞ'), findsOneWidget);
  });
}
