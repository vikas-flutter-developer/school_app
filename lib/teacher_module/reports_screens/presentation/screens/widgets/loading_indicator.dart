// lib/presentation/screens/widgets/loading_indicator.dart
import 'package:flutter/material.dart';
import '../../../../../core/utils/screen_util_helper.dart'; // added for responsiveness

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // initialize scaling

    return Center(
      child: SizedBox(
        width: ScreenUtilHelper.scaleWidth(32), // responsive size
        height: ScreenUtilHelper.scaleWidth(32),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}


// Add common_app_bar.dart from previous example if you haven't already
