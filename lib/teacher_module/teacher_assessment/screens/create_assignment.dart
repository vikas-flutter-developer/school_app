import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../../../routes/app_routes.dart';
import 'assignment_questions.dart';
import 'package:go_router/go_router.dart';

class CreateAssignment extends StatelessWidget implements PreferredSizeWidget {
  const CreateAssignment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: ScreenUtilHelper.scaleWidth(153),
                height: ScreenUtilHelper.scaleHeight(39),
                margin: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(8)),
                child: Image.asset(
                  'assets/images/edudibon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {},
              ),
              Positioned(
                right: ScreenUtilHelper.scaleWidth(15),
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(4)),
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                    minWidth: ScreenUtilHelper.scaleWidth(16),
                    minHeight: ScreenUtilHelper.scaleHeight(16),
                  ),
                  child: Center(
                    child: Text('3', style: AppStyles.whiteFont10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(40)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => GoRouter.of(context).pop(),
                ),
                Text("Assignment Title", style: AppStyles.headingLPlain),
              ],
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(25)),
            _buildDropdownLabel("Type of assignment*"),
            _buildDropdown(['MCQ', 'Subjective', 'Practical'], 'MCQ'),
            SizedBox(height: ScreenUtilHelper.scaleHeight(25)),
            _buildDropdownLabel("Timer*"),
            _buildDropdown(['Yes', 'No'], 'Yes'),
            SizedBox(height: ScreenUtilHelper.scaleHeight(25)),
            _buildDropdownLabel("Set Timer*"),
            _buildDropdown(['15 min', '30 min', '45 min', '1 hr'], '30 min'),
            SizedBox(height: ScreenUtilHelper.scaleHeight(25)),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDropdownLabel("Grading*"),
                      _buildStaticContainer('Marks'),
                    ],
                  ),
                ),
                SizedBox(width: ScreenUtilHelper.scaleWidth(16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Out of", style: AppStyles.heading14),
                      SizedBox(height: ScreenUtilHelper.scaleHeight(5)),
                      _buildStaticContainer('50'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(25)),
            _buildDropdownLabel("Apply condition*"),
            _buildDropdown(['above 45% pass', 'above 30% fail'], 'above 45% pass'),
            SizedBox(height: ScreenUtilHelper.scaleHeight(25)),
            Center(
              child: ElevatedButton(
                onPressed: ()=>context.push(AppRoutes.addAssignmentQuestions),
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.white,
                  backgroundColor: AppColors.primaryMedium,
                  minimumSize: Size(
                    ScreenUtilHelper.scaleWidth(100),
                    ScreenUtilHelper.scaleHeight(30),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(6)),
                  ),
                ),
                child: const Text("Create"),
              ),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtilHelper.scaleHeight(8)),
      child: Text(text, style: AppStyles.heading14),
    );
  }

  Widget _buildDropdown(List<String> items, String selected) {
    return Container(
      width: double.infinity,
      height: ScreenUtilHelper.scaleHeight(33),
      margin: EdgeInsets.only(top: ScreenUtilHelper.scaleHeight(5)),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(12)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(1)),
        border: Border.all(color: AppColors.parchment, width: 2.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selected,
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.tertiaryDarkest),
          dropdownColor: AppColors.white,
          style: AppStyles.dropdownText,
          isExpanded: true,
          items: items
              .map((type) => DropdownMenuItem<String>(
            value: type,
            child: Center(child: Text(type)),
          ))
              .toList(),
          onChanged: (value) {
            print('Selected: $value');
          },
        ),
      ),
    );
  }

  Widget _buildStaticContainer(String text) {
    return Container(
      width: double.infinity,
      height: ScreenUtilHelper.scaleHeight(34),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(12)),
      margin: EdgeInsets.only(top: ScreenUtilHelper.scaleHeight(5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(1)),
        border: Border.all(color: AppColors.parchment, width: 2.0),
      ),
      child: Center(
        child: Text(text, style: AppStyles.dropdownText),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
