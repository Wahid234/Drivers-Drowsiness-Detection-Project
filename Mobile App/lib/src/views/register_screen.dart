import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hather_app/src/controllers/c_auth.dart';
import 'package:hather_app/src/controllers/c_user.dart';
import 'package:hather_app/src/models/user.dart';
import 'package:hather_app/src/utils/theme/color.dart';
import 'package:hather_app/src/views/auth_screen.dart';
import 'package:hather_app/src/views/home_screen.dart';
import 'package:hather_app/src/views/verify_screen.dart';
import 'package:hather_app/src/views/shared/button_widget.dart';
import 'package:hather_app/src/views/shared/components.dart';
import 'package:hather_app/src/views/shared/text_field_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _errorMessage;

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
                'Register',
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
              controller: _nameController,
              labelText: 'Name',
              placeHolder: 'ex: Ahmed',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            TextFieldWidget(
              controller: _emailController,
              labelText: 'Email',
              placeHolder: 'ex: ahmed@test.com',
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
              controller: _passwordController,
              labelText: 'Password',
              placeHolder: 'ex: sdfjA37',
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                // You can add more password validation logic here if needed
                return null;
              },
            ),
            SizedBox(height: 16.h),
            TextFieldWidget(
              controller: _confirmPasswordController,
              labelText: 'Confirm Password',
              placeHolder: 'ex: sdfjA37',
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            ButtonWidget(
              text: 'Register',
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  FocusScope.of(context).unfocus();

                  final user = User(
                    id: '',
                    name: _nameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  final either = await CAuth.get(context).register(user);


                  if (either.isRight) {
                    CUser.get(context).user=(either as Right).value;
                    Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => VerifyScreen(),
                    //     ));
                  } else if (either is Left) {
                    // Registration failed
                    setState(() {
                      _errorMessage = either.value;
                    });
                  } else {
                    // Handle unexpected result
                  }
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
                      text: 'Have an account?  ',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.3799999952316284),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(
                        color: Color(0xFF6173D2),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ],
                ),
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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    // You can implement more robust email validation if needed
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
