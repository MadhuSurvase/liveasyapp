import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:liveasy_app/verification_screen.dart';
import 'localizationservice.dart';

class OtpScreen extends StatefulWidget {
  final String languageCode;

  const OtpScreen({Key? key, required this.languageCode}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String phoneNumber = '';
  bool isLoading = true;
  String verificationId = ''; // Firebase verification ID

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    try {
      await LocalizationService.load(widget.languageCode, 'otp');
      setState(() {
        isLoading = false;  // Set loading to false after loading localization data
      });
    } catch (e) {
      print("Error loading language: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to request OTP
  Future<void> _requestOTP() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Automatically sign in the user once OTP is verified
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification failed: ${e.message}");
      },
      codeSent: (String verId, int? resendToken) {
        setState(() {
          verificationId = verId;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationScreen(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verId) {
        setState(() {
          verificationId = verId;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: isLoading
              ? CircularProgressIndicator() // Show loading indicator while loading language
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocalizationService.translate("enter_mobile") ?? "Loading...",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                LocalizationService.translate("verification_text") ?? "Loading...",
                style: TextStyle(
                  color: const Color(0xFF6A6B7C),
                  fontSize: screenWidth * 0.045,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.04),
              Container(
                width: screenWidth * 0.8,
                child: IntlPhoneField(
                  decoration: InputDecoration(
                    labelText: LocalizationService.translate("mobile_number") ?? "Loading...",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'IN',
                  showCountryFlag: true,
                  onChanged: (phone) {
                    setState(() {
                      phoneNumber = phone.completeNumber;
                    });
                    print(phone.completeNumber);
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              GestureDetector(
                onTap: _requestOTP,  // Send OTP on button tap
                child: Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    color: const Color(0XFF2A3B62),
                  ),
                  child: Center(
                    child: Text(
                      LocalizationService.translate("continue_button") ?? "Loading...",
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
