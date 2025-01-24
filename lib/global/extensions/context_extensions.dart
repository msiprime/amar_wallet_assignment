import 'package:flutter/material.dart';

extension contextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  Size get size => MediaQuery.sizeOf(this);

  double get height => size.height;

  double get width => size.width;
}
