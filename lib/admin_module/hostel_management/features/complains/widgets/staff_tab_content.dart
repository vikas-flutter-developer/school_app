import 'package:flutter/material.dart';

import 'student_tab_content.dart'; // Reusing student tab content for now

class StaffTabContent extends StatelessWidget {
  const StaffTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    // For now, Staff tab displays the same content as Student tab
    // You can replace this with specific content for Staff if needed
    return const StudentTabContent();
    // return Container(width: 388, height: 138, color: AppColors.error); // Original placeholder
  }
}
