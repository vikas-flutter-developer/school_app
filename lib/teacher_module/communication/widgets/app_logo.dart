// lib/core/widgets/app_logo.dart
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double height;
  const AppLogo({Key? key, this.height = 30}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace with your actual logo widget or Image.asset
    return Image.asset('assets/images/edudibon_logo.png', height: height);
  }
}
