import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class JsonLoader {
  Future<Map<String, dynamic>> loadJson(String path) async {
    try {
      String jsonString = await rootBundle.loadString(path);
      final jsonResponse = json.decode(jsonString);
      return jsonResponse;
    } catch (e) {
      print("Error loading JSON: $e");
      return {};
    }
  }
}
