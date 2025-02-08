import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hather_app/src/utils/extensions/context_extensions.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({
    super.key,
    this.child,
    this.backgroundImage,
    this.statusBarColor,
    this.scaffoldBackgroundColor,
    this.floatingActionButton,
    this.implySafeAreaTopPadding = true,
  });
  final Widget? child;
  final Widget? backgroundImage;
  final Color? statusBarColor;
  final Color? scaffoldBackgroundColor;
  final Widget? floatingActionButton;
  final bool? implySafeAreaTopPadding;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: statusBarColor ?? Colors.transparent,
          statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: scaffoldBackgroundColor,
        body: Stack(
          children: [
            if (backgroundImage != null) backgroundImage!,
            Padding(
                padding: EdgeInsets.only(top: context.statusBarHeight,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: child)
          ],
        ),
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
