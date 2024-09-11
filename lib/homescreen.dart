import 'package:flutter/material.dart';

import 'OTP_Screen.dart';
import 'applocalization.dart';

class Homescreen extends StatefulWidget {
  final Function(Locale) setLocale; // Function to set the locale

  const Homescreen({Key? key, required this.setLocale}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String _selectedLanguage = 'English';
  final List<String> _languages = ['English', 'Hindi', 'Marathi'];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalization.of(context)?.translate('select_language') ??
                    'Please Select your Language',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                AppLocalization.of(context)?.translate('change_language') ??
                    'You can change the Language at any time',
                style: TextStyle(
                  color: const Color(0xFF6A6B7C),
                  fontSize: screenWidth * 0.045,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.04),
              // Language selector dropdown
              Container(
                width: screenWidth * 0.5,
                height: screenHeight * 0.07,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                ),
                child: DropdownButton<String>(
                  value: _selectedLanguage,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF6A6B7C)),
                  items: _languages.map((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Text(
                        language,
                        style: const TextStyle(color: Color(0xFF6A6B7C)),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // Ensure the newValue is not null
                    if (newValue != null) {
                      setState(() {
                        _selectedLanguage = newValue;

                        // Set the locale based on the selected language
                        if (_selectedLanguage == 'English') {
                          widget.setLocale(const Locale('en', 'US'));
                        } else if (_selectedLanguage == 'Hindi') {
                          widget.setLocale(const Locale('hi', 'IN'));
                        } else if (_selectedLanguage == 'Marathi') {
                          widget.setLocale(const Locale('mr', 'IN'));
                        }
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              GestureDetector(
                onTap: () {
                  // Navigate to OtpScreen with selected language code
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtpScreen(
                        languageCode: _selectedLanguage == 'English'
                            ? 'en'
                            : _selectedLanguage == 'Hindi'
                            ? 'hi'
                            : 'mr',
                      ),
                    ),
                  );
                },
                child: Container(
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    color: const Color(0XFF2A3B62),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalization.of(context)?.translate('next') ?? 'NEXT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.05,
                      ),
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
