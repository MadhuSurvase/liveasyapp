import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liveasy_app/profilescreen.dart'; // Ensure this path is correct
import 'package:pinput/pinput.dart';
import 'localizationservice.dart';


class VerificationScreen extends StatefulWidget {
  final String verificationId; // Passed from the OTP screen to hold the verification ID

  const VerificationScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String _languageCode = 'en'; // Default language
  String otpCode = ''; // To store the OTP entered by the user
  bool isLoading = false; // To show a loading indicator when verifying OTP
  final FirebaseAuth _auth = FirebaseAuth.instance; // FirebaseAuth instance

  @override
  void initState() {
    super.initState();
    _loadLocalization(); // Load localization strings
  }

  Future<void> _loadLocalization() async {
    await LocalizationService.load(_languageCode, 'verification_screen');
    setState(() {}); // Refresh the UI to reflect changes
  }

  Future<void> _verifyOtp() async {
    setState(() {
      isLoading = true; // Start loading when verifying OTP
    });

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpCode,
      );

      await _auth.signInWithCredential(credential);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        ),
      );
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading if verification fails
      });
      print('Error verifying OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP, please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.25),
        child: Center(
          child: Column(
            children: [
              Text(
                LocalizationService.translate('verify_phone') ?? 'Verify Phone',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.08,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                LocalizationService.translate('code_sent_to') ?? 'Code is sent to your phone',
                style: TextStyle(
                  color: Color(0xFF6A6B7C),
                  fontSize: screenWidth * 0.05,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: screenHeight * 0.03),
              buildPinPut(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocalizationService.translate('did_not_receive_code') ?? 'Didn’t receive the code?',
                      style: TextStyle(
                        color: Color(0xFF6A6B7C),
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('Requesting code again...');
                      },
                      child: Text(
                        LocalizationService.translate('request_again') ?? ' Request Again',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              isLoading
                  ? CircularProgressIndicator()
                  : GestureDetector(
                onTap: _verifyOtp,
                child: Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.08,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    color: Color(0XFF2A3B62),
                  ),
                  child: Center(
                    child: Text(
                      LocalizationService.translate('verify_and_continue') ?? 'VERIFY AND CONTINUE',
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

  Widget buildPinPut(double screenWidth, double screenHeight) {
    return Pinput(
      length: 6,
      mainAxisAlignment: MainAxisAlignment.center,
      defaultPinTheme: PinTheme(
        width: screenWidth * 0.12,
        height: screenHeight * 0.07,
        textStyle: TextStyle(
          fontSize: screenWidth * 0.05,
          color: Colors.black,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (pin) {
        setState(() {
          otpCode = pin;
        });
      },
      onCompleted: (pin) => print('OTP entered: $pin'),
    );
  }
}
