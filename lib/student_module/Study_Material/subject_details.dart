import '../../../core/utils/app_decorations.dart';
import 'package:flutter/material.dart';
import '../../core/utils/app_styles.dart';
import 'model/study_material_model.dart';


class SubjectDetailsScreen extends StatelessWidget {
  final StudyMaterial subject;

  const SubjectDetailsScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          subject.title,
          style: TextStyle(fontWeight: AppStyles.weight.regular), // Removed bold styling
        ),
      ),
      body: Padding(
        padding: AppDecorations.mediumPadding,
        
      ),
    );
  }
}
