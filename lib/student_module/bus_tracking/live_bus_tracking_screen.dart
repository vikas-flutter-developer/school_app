import 'package:flutter/material.dart';
import '../../core/utils/screen_util_helper.dart'; // Make sure this import is correct

class LiveBusTrackingScreen extends StatelessWidget {
  final String busNumber;

  const LiveBusTrackingScreen({super.key, required this.busNumber});

  @override
  Widget build(BuildContext context) {
    // Initialize screen util
    ScreenUtilHelper.init(context);

    final titleFontSize = ScreenUtilHelper.fontSize(18);
    final bodyFontSize = ScreenUtilHelper.fontSize(14);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Live Tracking: $busNumber',
          style: TextStyle(fontSize: titleFontSize),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(24),
            vertical: ScreenUtilHelper.height(16),
          ),
          child: Text(
            'Live bus tracking details for $busNumber will be shown here.',
            style: TextStyle(
              fontSize: bodyFontSize,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
