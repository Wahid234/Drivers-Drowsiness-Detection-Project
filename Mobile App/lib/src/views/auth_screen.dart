import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hather_app/src/utils/theme/color.dart';
import 'package:hather_app/src/views/shared/app_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      scaffoldBackgroundColor: AppColors.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                children: [
                  SizedBox(height: 45.h),
                  Text(
                    'HATHER',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFFFDFD),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Ensuring safety by monitoring for signs of sleep or fatigue in real-time',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFFFDFD),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: 42.h),
                ],
              )),
          Expanded(
              child: ClipRRect(
            borderRadius:
                BorderRadiusDirectional.only(topStart: Radius.circular(50.h)),
            child: ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h)
                      .copyWith(bottom: 10.h),
                  child: SingleChildScrollView(child: child),
                )),
          )),
        ],
      ),
    );
  }
}
