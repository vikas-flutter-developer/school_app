import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import 'package:go_router/go_router.dart';

class AssignmentPreviewScreen extends StatefulWidget {
  const AssignmentPreviewScreen({super.key});

  @override
  _AssignmentPreviewScreenState createState() => _AssignmentPreviewScreenState();
}

class _AssignmentPreviewScreenState extends State<AssignmentPreviewScreen> {
  final int questionCount = 5;
  List<int> selectedIndexes = List.generate(5, (_) => -1); // -1 = not selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              width: ScreenUtilHelper.scaleWidth(153),
              height: ScreenUtilHelper.scaleHeight(39),
              margin: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(8)),
              child: Image.asset('assets/images/edudibon.png', fit: BoxFit.contain),
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
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
                  child: const Center(
                    child: Text('3', style: TextStyle(color: AppColors.white, fontSize: 10)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(8)),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => GoRouter.of(context).pop(),
                ),
                Text("Assignment Title", style: TextStyle(fontSize: ScreenUtilHelper.scaleText(20), fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(45)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total 50 marks", style: TextStyle(fontSize: ScreenUtilHelper.scaleText(14), fontWeight: FontWeight.w400, color: AppColors.black)),
                    Text("00:30", style: TextStyle(fontSize: ScreenUtilHelper.scaleText(16), fontWeight: FontWeight.w400, color: AppColors.error)),
                  ],
                ),
                Text("All questions are compulsory", style: TextStyle(fontSize: ScreenUtilHelper.scaleText(10), fontWeight: FontWeight.w400, color: AppColors.black)),
              ],
            ),
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(25)),
          Expanded(
            child: ListView.builder(
              itemCount: questionCount,
              itemBuilder: (context, questionIndex) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(45)),
                      child: Container(
                        width: double.infinity,
                        height: ScreenUtilHelper.scaleHeight(125),
                        padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(10)),
                        margin: EdgeInsets.only(bottom: ScreenUtilHelper.scaleHeight(15)),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.cloud),
                          borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(8)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${questionIndex + 1}. How is the weather?',
                              style: TextStyle(
                                fontSize: ScreenUtilHelper.scaleText(12),
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
                            buildOption(questionIndex, 0, 'a. good'),
                            buildOptionWithMarks(questionIndex, 1, 'b. bad', '1M'),
                            buildOption(questionIndex, 2, 'c. worst'),
                            buildOption(questionIndex, 3, 'd. none of the above'),
                          ],
                        ),
                      ),
                    ),
                    if (questionIndex == questionCount - 1)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(45)),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.white,
                            backgroundColor: AppColors.primaryMedium,
                            minimumSize: Size(ScreenUtilHelper.scaleWidth(100), ScreenUtilHelper.scaleHeight(30)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(6)),
                            ),
                          ),
                          child: const Text("Publish"),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOption(int questionIndex, int optionIndex, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtilHelper.scaleHeight(6)),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                selectedIndexes[questionIndex] = optionIndex;
              });
            },
            child: Container(
              width: ScreenUtilHelper.scaleWidth(14),
              height: ScreenUtilHelper.scaleHeight(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedIndexes[questionIndex] == optionIndex ? AppColors.success : AppColors.blackMediumEmphasis,
              ),
              child: selectedIndexes[questionIndex] == optionIndex
                  ? const Icon(Icons.check, size: 8, color: AppColors.white)
                  : null,
            ),
          ),
          SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
          Text(text, style: AppStyles.headingTextSmall),
        ],
      ),
    );
  }

  Widget buildOptionWithMarks(int questionIndex, int optionIndex, String text, String marks) {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtilHelper.scaleHeight(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildOption(questionIndex, optionIndex, text),
          Padding(
            padding: EdgeInsets.only(right: ScreenUtilHelper.scaleWidth(8)),
            child: Text(marks, style: AppStyles.headingTextSmall),
          ),
        ],
      ),
    );
  }
}
