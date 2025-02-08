import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  /// The same of [MediaQuery.of(context).size]
  Size get mediaQuerySize => MediaQuery
      .sizeOf(this);

  /// The same of [MediaQuery.of(context).size.height]
  /// Note: updates when you rezise your screen (like on a browser or
  /// desktop window)
  double get height => mediaQuerySize.height;

  /// The same of [MediaQuery.of(context).size.width]
  /// Note: updates when you rezise your screen (like on a browser or
  /// desktop window)
  double get width => mediaQuerySize.width;

  double get statusBarHeight =>
      View.of(this).padding.top / View.of(this).devicePixelRatio;
}
