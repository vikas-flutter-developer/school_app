import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';
import '../../student_module/Study_Material/model/study_material_model.dart';

class SubjectCard extends StatelessWidget {
  final StudyMaterial subject;
  final VoidCallback onTap;
  final String buttonText;

  const SubjectCard({
    super.key,
    required this.subject,
    required this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondaryAccentLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          subject.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            side: const BorderSide(color: Colors.black, width: 0.5),
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 8,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
