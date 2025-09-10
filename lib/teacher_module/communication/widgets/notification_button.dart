// lib/core/widgets/notification_button.dart
import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Badge(
        // Use Badge widget for notification count
        label: Text('1'), // Replace with actual count from state if needed
        isLabelVisible: true, // Set visibility based on count
        child: Icon(Icons.notifications_outlined),
      ),
      onPressed: () {
        // Handle notification tap
      },
    );
  }
}
