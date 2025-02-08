import 'package:flutter/material.dart';

showToast(BuildContext context, String title) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(title),
    ));
