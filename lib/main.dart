import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart'; // Import the generated Firebase options
import 'package:liveasy_app/homescreen.dart';
import 'applocalization.dart'; // Your localization file

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with platform-specific options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', 'US'); // Default locale

  // Method to change the locale dynamically
  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shipping App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      locale: _locale, // Set the locale dynamically
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('hi', 'IN'), // Hindi
        Locale('mr', 'IN'), // Marathi
      ],
      localizationsDelegates: const [
        AppLocalization.delegate, // Custom localization delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Homescreen(setLocale: _setLocale), // Pass the setLocale method to Homescreen
    );
  }
}
