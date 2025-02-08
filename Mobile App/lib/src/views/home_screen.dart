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
import 'package:hather_app/src/utils/theme/color.dart';
import 'package:hather_app/src/views/dialog_widget.dart';
import 'package:hather_app/src/views/login_screen.dart';
import 'package:hather_app/src/views/shared/button_widget.dart';
import 'package:hather_app/src/controllers/c_home.dart';
import 'package:hather_app/src/controllers/c_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isCamera = false;
  CameraController? _controller;
  List<CameraDescription>? cameras;
  late Timer _timer;
  XFile? file;

  @override
  void initState() {
    super.initState();
    // Initialize camera when the widget is first created
    _initializeCamera();

    // Start timer to take picture every 10 seconds
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      if (isCamera) {
        _controller!.takePicture().then((file) {
          _uploadPicture(file);
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose camera controller when the widget is disposed
    _controller?.dispose();
    // Cancel timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    // Get available cameras
    cameras = await availableCameras();
    // Find the front camera
    final frontCamera = cameras!.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () =>
          cameras![0], // Use the first camera if front camera not found
    );
    // Initialize the camera controller with the front camera
    _controller = CameraController(frontCamera, ResolutionPreset.medium);
    // Initialize the camera controller
    await _controller!.initialize();
    // Update the state to rebuild the UI with the camera preview
    setState(() {});
  }

  bool _isCapturing = false;

  Future<void> _uploadPicture(XFile file) async {
    // Check if a capture operation is already in progress
    if (_isCapturing) {
      return;
    }

    try {
      // Set the flag to indicate that a capture operation is now in progress
      _isCapturing = true;

      // Ensure the camera controller is initialized and capturing
      if (_controller != null && _controller!.value.isInitialized) {
        // Construct a path for the image to be saved
        // Upload the image
        if (!mounted) return;
        final message = await CHome.get(context).uploadImage(file.path);
        if (!mounted) return;
        if (message?.message.isNotEmpty == true) {
          if (message?.status == 2) {
            FlutterRingtonePlayer().play(
                fromAsset: "assets/emergency.wav",
                // will be the sound on Android
                ios: IosSounds.glass // will be the sound on iOS
                );
          }
          showDialog(
              context: context,
              builder: (context) {
                //pop up dialog after 3 seconds
                Future.delayed(const Duration(seconds: 6), () {
                  if (context.mounted) {
                    Navigator.pop(context);
                    FlutterRingtonePlayer().stop();
                  }
                });
                return DialogWidget(message: message);
              });
        }
      }
    } finally {
      _isCapturing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CUser>(builder: (context, value, child) {
        return Column(
          children: [
            Container(
              height: 132.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50.h),
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    SizedBox(
                      width: 100.h,
                      child: Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: TextButton(
                          onPressed: () {
                            value.logout();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ));
                          },
                          child: Text(
                            CUser.get(context).user != null
                                ? "Logout"
                                : 'Login',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'IBM Plex Sans Condensed',
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Text(
                          'HATHER',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFFFFDFD),
                            fontSize: 24,
                            fontFamily: 'IBM Plex Sans Condensed',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100.h,
                      child: Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 45.h,
                          width: 45.h,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: isCamera &&
                      (_controller != null && _controller!.value.isInitialized)
                  ? Center(
                      child: SizedBox(
                        height: 500.h,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(14.r),
                            child: CameraPreview(_controller!)),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 53.h),
                          const Text(
                            'Make your face attention \nto the camera!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF6173D2),
                              fontSize: 18,
                              fontFamily: 'IBM Plex Sans Condensed',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          SizedBox(height: 35.h),
                          if (file != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Image.file(
                                File(file!.path),
                                height: 400.h,
                                width: 400.h,
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            SvgPicture.asset("assets/images/image.svg"),
                        ],
                      ),
                    ), // Show camera preview if initialized
            ),
            Padding(
              padding: EdgeInsets.all(20.h),
              child: Row(
                children: [
                  if (!isCamera) ...[
                    Expanded(
                      child: ButtonWidget(
                        text: 'Upload image ',
                        onPressed: () {
                          file = null;
                          final picker = ImagePicker();
                          picker
                              .pickImage(source: ImageSource.gallery)
                              .then((file) {
                            setState(() {
                              this.file = file;
                            });
                            if (file != null) {
                              _uploadPicture(file);
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 20.h),
                  ],
                  Expanded(
                    child: ButtonWidget(
                      text: isCamera ? 'Stop track ' : 'Start track ',
                      onPressed: () {
                        file = null;
                        setState(() => isCamera = !isCamera);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
