import 'package:flutter/material.dart';

extension contextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  Size get size => MediaQuery.sizeOf(this);

  double get height => size.height;

  double get width => size.width;

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
}

extension SnackBarExtension on BuildContext {
  void showSnackBar(
    String text, {
    bool dismissible = true,
    Color color = Colors.white,
    Duration duration = const Duration(seconds: 4),
    SnackBarBehavior? behavior,
    SnackBarAction? snackBarAction,
    String? solution,
    DismissDirection dismissDirection = DismissDirection.down,
  }) =>
      ScaffoldMessenger.of(this)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(text),
            action: snackBarAction,
            behavior: behavior,
            backgroundColor: color,
            dismissDirection: dismissDirection,
            duration: duration,
          ),
        );

  void closeSnackBars() {
    ScaffoldMessenger.of(this).clearSnackBars();
  }
}
