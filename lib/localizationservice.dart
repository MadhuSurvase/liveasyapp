import 'dart:convert';


import 'package:flutter/services.dart';

class LocalizationService {
  static Map<String, String>? _localizedStrings;

  static Future<void> load(String languageCode, String screenName) async {
    try {
      String jsonString = await rootBundle.loadString('assets/lang/$screenName/$languageCode.json');
      print("JSON Loaded: $jsonString"); // Debug line
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      _localizedStrings = jsonMap.map((key, value) {
        return MapEntry(key, value.toString());
      });

      print("Localized Strings: $_localizedStrings"); // Debug line
    } catch (e) {
      print("Error loading language: $e"); // Debug line
    }
  }

  static String? translate(String key) {
    return _localizedStrings?[key];
  }
}
