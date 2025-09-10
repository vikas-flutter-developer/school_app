import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart'; // ✅ Import
import '../staff_management/model/employee_entity.dart';

class DocumentsCard extends StatelessWidget {
  final EmployeeEntity employee;

  const DocumentsCard({super.key, required this.employee});

  Widget docRow(String title, String value) {
    return Container(
      width: double.infinity,
      color: AppColors.cardBackground,
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtilHelper.height(12),
        horizontal: ScreenUtilHelper.width(12),
      ),
      child: Text(
        "$title - $value",
        style: AppStyles.body,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final docs = employee.documentImages;
    final docLabels = employee.documentLabels;

    final int maxDocs = 8;
    final displayedDocs = docs.length > maxDocs ? docs.sublist(0, maxDocs) : docs;
    final displayedLabels = docLabels.length > maxDocs ? docLabels.sublist(0, maxDocs) : docLabels;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(16),
        vertical: ScreenUtilHelper.height(12),
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              ScreenUtilHelper.width(12),
              ScreenUtilHelper.height(16),
              ScreenUtilHelper.width(12),
              ScreenUtilHelper.height(8),
            ),
            child: const Text(
              "Documents",
              style: AppStyles.sectionHeading,
            ),
          ),
          const Divider(height: 1),
          docRow("Adhar Card", employee.adharCardNumber),
          const Divider(height: 1),
          docRow("Pancard Number", employee.pancardNumber),
          const Divider(height: 1),
          docRow("Department", employee.documentDepartment),
          const Divider(height: 1),
          SizedBox(height: ScreenUtilHelper.height(12)),

          // Grid for document images
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(12)),
            child: Wrap(
              spacing: ScreenUtilHelper.width(12),
              runSpacing: ScreenUtilHelper.height(16),
              children: List.generate(displayedDocs.length, (index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                      child: Image.network(
                        displayedDocs[index],
                        height: ScreenUtilHelper.height(40), // ScreenUtilHelper
                        width: ScreenUtilHelper.width(60),   // ScreenUtilHelper
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          String fallbackAsset;

                          // Select asset image based on index
                          switch (index % 7) {
                            case 0:
                              fallbackAsset = 'assets/images/aadhar.png';
                              break;
                            case 1:
                              fallbackAsset = 'assets/images/pan.png';
                              break;
                            case 2:
                              fallbackAsset = 'assets/images/address_proof.png';
                              break;
                            case 3:
                              fallbackAsset = 'assets/images/degree.png';
                              break;
                            case 4:
                              fallbackAsset = 'assets/images/degree.png';
                              break;
                            case 5:
                              fallbackAsset = 'assets/images/payslip1.png';
                              break;
                            case 6:
                            default:
                              fallbackAsset = 'assets/images/payslip1.png';
                              break;
                          }

                          return Image.asset(
                            fallbackAsset,
                            height: ScreenUtilHelper.height(40), // ScreenUtilHelper
                            width: ScreenUtilHelper.width(60),   // ScreenUtilHelper
                            fit: BoxFit.cover,
                          );
                        },
                      ),


                    ),
                    SizedBox(height: ScreenUtilHelper.height(6)),
                    SizedBox(
                      width: ScreenUtilHelper.width(90),
                      child: Text(
                        displayedLabels[index],
                        style: AppStyles.caption,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          SizedBox(height: ScreenUtilHelper.height(12)),
        ],
      ),
    );
  }
}
