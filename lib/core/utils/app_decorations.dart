import 'package:flutter/material.dart';

class AppDecorations{
  // Borders
  static const Border defaultBorder = Border.fromBorderSide(
    BorderSide(width: 1),
  );

  static const Border dottedBorder = Border.fromBorderSide(
    BorderSide(width: 1, style: BorderStyle.solid), // Replace with dashed border using external lib
  );

  // Border Radius
  static const BorderRadius smallRadius = BorderRadius.all(Radius.circular(4));
  static const BorderRadius normalRadius = BorderRadius.all(Radius.circular(8));
  static const BorderRadius mediumRadius = BorderRadius.all(Radius.circular(12));
  static const BorderRadius largeRadius = BorderRadius.all(Radius.circular(16));
  static const BorderRadius circleRadius = BorderRadius.all(Radius.circular(25));

  // Padding
  static const EdgeInsets smallPadding = EdgeInsets.all(8);
  static const EdgeInsets mediumPadding = EdgeInsets.all(16);
  static const EdgeInsets largePadding = EdgeInsets.all(24);

  // Margin (if needed)
  static const EdgeInsets smallMargin = EdgeInsets.all(8);
  static const EdgeInsets mediumMargin = EdgeInsets.all(16);
  static const EdgeInsets largeMargin = EdgeInsets.all(24);
}
