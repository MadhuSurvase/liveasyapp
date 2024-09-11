import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var Color_shipperBorderColor = Color(0xff2E3B62);
  var Color_transpoterBorderColor = Color(0xff2E3B62);

  int selectedPlanIndex = 0;

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.2, left: screenWidth * 0.05),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.05,
                ),
                Text(
                  'Please select your Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Container(
              width: screenWidth * 0.8,
              padding: EdgeInsets.all(screenWidth * 0.05),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.zero),
                border: Border.all(color: Color_shipperBorderColor),
              ),
              child: Row(
                children: [
                  Text(
                    'Shipper',
                    style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.04),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPlanIndex = 0;
                        Color_shipperBorderColor = Color(0xff2E3B62); // Set color to dark blue
                        Color_transpoterBorderColor = Colors.grey; // Reset transporter color
                      });
                    },
                    child: Container(
                      width: screenWidth * 0.45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: screenWidth * 0.07,
                            width: screenWidth * 0.07,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (selectedPlanIndex == 0)
                                  ? Color(0xff2E3B62)
                                  : Colors.white,
                              border: Border.all(
                                color: (selectedPlanIndex == 0)
                                    ? Colors.white
                                    : Colors.black,
                                width: (selectedPlanIndex == 0) ? 2 : 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Container(
              width: screenWidth * 0.8,
              padding: EdgeInsets.all(screenWidth * 0.05),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.zero),
                border: Border.all(color: Color_transpoterBorderColor),
              ),
              child: Row(
                children: [
                  Text(
                    'Transporter',
                    style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.04),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      selectedPlanIndex = 1;
                      setState(() {});
                      Color_shipperBorderColor = Colors.grey;
                    },
                    child: Container(
                      width: screenWidth * 0.45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: screenWidth * 0.07,
                            width: screenWidth * 0.07,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (selectedPlanIndex == 1)
                                  ? Color(0xff2E3B62)
                                  : Colors.white,
                              border: Border.all(
                                color: (selectedPlanIndex == 1)
                                    ? Colors.white
                                    : Colors.black,
                                width: (selectedPlanIndex == 1) ? 2 : 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.08,
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                color: Color(0XFF2A3B62),
              ),
              child: Center(
                child: Text(
                  'CONTINUE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.06,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
