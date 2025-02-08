import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hather_app/src/controllers/c_user.dart';
import 'package:hather_app/src/models/message.dart';
import 'package:hather_app/src/utils/theme/color.dart';
import 'package:hather_app/src/views/dialog_widget.dart';
import 'package:hather_app/src/views/login_screen.dart';
import 'package:hather_app/src/views/shared/button_widget.dart';
import 'package:hather_app/src/controllers/c_home.dart';
import 'package:hather_app/src/controllers/c_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({super.key, this.message});
final Message? message;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 150.h,
                padding: EdgeInsets.all(20.h),
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.all(20.h),
                decoration: BoxDecoration(
                  color: message?.status == 2
                      ? Colors.red
                      : AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(20.h),
                ),
                child: Text(
                  message!.message,
                  style: const TextStyle(
                    color: Color(0xFF6173D2),
                    fontSize: 15,
                    fontFamily: 'IBM Plex Sans Condensed',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              CircleAvatar(
                  backgroundColor: Colors.white,
                  child: SvgPicture.asset(
                      "assets/images/notification.svg"))
            ],
          ),
        ],
      ),
    );
  }
}
