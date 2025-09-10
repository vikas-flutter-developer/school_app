import 'package:flutter/material.dart';

import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../models/study_material_model.dart';

class StudyMaterialItem extends StatelessWidget {
  final StudyMaterials material;

  const StudyMaterialItem({super.key, required this.material});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtilHelper.scaleHeight(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: ScreenUtilHelper.scaleWidth(16),
            ),
            child: Row(
              children: [
                Container(
                  width: ScreenUtilHelper.scaleWidth(30),
                  height: ScreenUtilHelper.scaleHeight(30),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(material.iconPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: ScreenUtilHelper.scaleWidth(20)),
                Text(
                  material.name,
                  style: AppStyles.body14BlackPlain,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: ScreenUtilHelper.scaleWidth(30),
            ),
            child: Text(
              material.date,
              style: AppStyles.body10Black,
            ),
          ),
        ],
      ),
    );
  }
}
