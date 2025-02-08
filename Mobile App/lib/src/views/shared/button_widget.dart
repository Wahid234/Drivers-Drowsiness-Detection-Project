import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hather_app/src/utils/theme/color.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading,
  }) : super(key: key);
  final String text;
  final Function()? onPressed;
  final bool? isLoading;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  late bool isLoading;

  @override
  void initState() {
    isLoading = widget.isLoading ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10.h)),
      child: MaterialButton(
          onPressed: isLoading || widget.onPressed == null
                  ? null
                  : () async {
                      isLoading = true;
                      if (mounted) {
                        setState(() {});
                      }
                      await widget.onPressed!();
                      if (!mounted) return;
                      isLoading = false;
                      if (mounted) {
                        setState(() {});
                      }
                    },
          minWidth: double.infinity,
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.h)),
          height: 60.h,
          child: Center(
            child: Builder(builder: (context) {
              if (isLoading) {
                return CupertinoActivityIndicator(
                    color: Colors.white, radius: 12.h);
              }
              return Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              );
            }),
          )),
    );
  }
}
