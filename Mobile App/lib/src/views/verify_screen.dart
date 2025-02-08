import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hather_app/src/utils/theme/color.dart';
import 'package:hather_app/src/views/auth_screen.dart';
import 'package:hather_app/src/views/home_screen.dart';
import 'package:hather_app/src/views/shared/button_widget.dart';
import 'package:hather_app/src/views/shared/text_field_widget.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  String _verificationCode = '';

  @override
  Widget build(BuildContext context) {
    return AuthScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50.h),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Verify',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 30.sp,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          SizedBox(height: 36.h),
          TextFieldWidget(
            labelText: 'Code',
            placeHolder: 'ex: 12345',
            onChanged: (value) {
              _verificationCode = value;
            },
          ),
          SizedBox(height: 16.h),
          // TextButton(
          //   onPressed: () {
          //     // Implement logic to resend verification code
          //   },
          //   style: ButtonStyle(
          //       padding: MaterialStatePropertyAll(
          //           EdgeInsets.symmetric(horizontal: 4.h)),
          //       shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10.h)))),
          //   child: Text(
          //     'Resend code',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       color: Colors.black.withOpacity(0.3799999952316284),
          //       fontSize: 16,
          //       fontWeight: FontWeight.w600,
          //       height: 0,
          //     ),
          //   ),
          // ),
          SizedBox(height: 16.h),
          ButtonWidget(
            text: 'Verify',
            onPressed: () {
              // Check if verification code is correct
              if (_verificationCode == '123456') {
                FocusScope.of(context).unfocus();
                // Navigate to the home screen if verification code is correct
                Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()));
              } else {
                // Display error message or handle incorrect verification code
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Invalid Code'),
                    content: Text('The verification code entered is incorrect.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          SizedBox(height: 100.h),
          Text(
            'By using the application, you agree to the terms of use and privacy policy',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF6173D2),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          )
        ],
      ),
    );
  }
}
