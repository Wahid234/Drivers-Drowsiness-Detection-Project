import 'package:either_dart/either.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hather_app/src/controllers/c_auth.dart';
import 'package:hather_app/src/controllers/c_user.dart';
import 'package:hather_app/src/utils/theme/color.dart';
import 'package:hather_app/src/views/auth_screen.dart';
import 'package:hather_app/src/views/home_screen.dart';
import 'package:hather_app/src/views/register_screen.dart';
import 'package:hather_app/src/views/verify_screen.dart';
import 'package:hather_app/src/views/shared/button_widget.dart';
import 'package:hather_app/src/views/shared/components.dart';
import 'package:hather_app/src/views/shared/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthScreen(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Login',
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
              controller: email,
              labelText: 'Email',
              placeHolder: 'ex: test@gmail.com',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!isValidEmail(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },

            ),
            SizedBox(height: 16.h),
            TextFieldWidget(
              controller: password,
              labelText: 'Password',
              placeHolder: 'ex: sdfjA37',
              validator: (value) => value == null || value.isEmpty == true
                  ? "This field is required"
                  : null,
            ),
            SizedBox(height: 16.h),
            // TextButton(
            //   onPressed: () {},
            //   style: ButtonStyle(
            //       padding: MaterialStatePropertyAll(
            //           EdgeInsets.symmetric(horizontal: 4.h)),
            //       shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10.h)))),
            //   child: Text(
            //     'forget Password',
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
              text: 'Log in',
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;
                FocusScope.of(context).unfocus();
                final either =
                    await CAuth.get(context).login(email.text, password.text);
                if (!mounted) return;
                if (either.isLeft) {
                  showToast(context,
                      "This user does not exist, please check the data");
                } else {
                  CUser.get(context).user=(either as Right).value;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                }
              },
            ),
            SizedBox(height: 16.h),
            Align(
              alignment: Alignment.topCenter,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'New User?  ',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.3799999952316284),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    TextSpan(
                      text: 'Register',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to the Register screen here
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        },
                      style: TextStyle(
                        color: Color(0xFF6173D2),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
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
      ),
    );
  }
  bool isValidEmail(String email) {
    // You can implement more robust email validation if needed
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
