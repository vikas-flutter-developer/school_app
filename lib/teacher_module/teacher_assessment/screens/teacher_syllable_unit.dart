import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/screens/teacher_syllable_unitscreen.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/app_routes.dart';

class TeacherSyllableUnit extends StatefulWidget {
  final int notificationCount;
  final String syllabusTitle;

  const TeacherSyllableUnit({
    Key? key,
    this.notificationCount = 3,
    required this.syllabusTitle,
  }) : super(key: key);

  @override
  _MyTeacherSyllableUnitState createState() => _MyTeacherSyllableUnitState();
}

class _MyTeacherSyllableUnitState extends State<TeacherSyllableUnit> {
  final List<Map<String, dynamic>> units = [
    {
      'name': 'Unit 1',
      'topics': [
        {'title': 'Newton\'s Law', 'progress': 0.5, 'contents': ['Content', 'Content', 'Content', 'Content', 'Content']},
        {'title': 'Gravity', 'progress': 0.3, 'contents': ['Content', 'Content', 'Content', 'Content', 'Content']},
        {'title': 'Energy', 'progress': 0.7, 'contents': ['Content', 'Content', 'Content', 'Content', 'Content']},
        {'title': 'Momentum', 'progress': 0.2, 'contents': ['Content', 'Content', 'Content', 'Content', 'Content']},
      ],
    },
    {
      'name': 'Unit 2',
      'topics': [
        {'title': 'Thermodynamics', 'progress': 0.5, 'contents': ['Content', 'Content', 'Content', 'Content', 'Content']},
      ],
    },
  ];

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
                child: Image.asset('assets/images/edudibon.png', fit: BoxFit.contain),
              ),
            ),
            const Spacer(),
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
              if (widget.notificationCount > 0)
                Positioned(
                  right: ScreenUtilHelper.scaleWidth(15),
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(4)),
                    decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                    constraints: BoxConstraints(
                      minWidth: ScreenUtilHelper.scaleWidth(16),
                      minHeight: ScreenUtilHelper.scaleHeight(16),
                    ),
                    child: Center(
                      child: Text('${widget.notificationCount}', style: AppStyles.whiteFont10),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: ScreenUtilHelper.scaleWidth(8),
              right: ScreenUtilHelper.scaleWidth(8),
              top: ScreenUtilHelper.scaleHeight(8),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => GoRouter.of(context).pop(),
                ),
                Text(widget.syllabusTitle, style: AppStyles.headingLNoColor),
              ],
            ),
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(8)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(units.length, (unitIndex) {
                    final unit = units[unitIndex];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(8)),
                          child: Row(
                            children: [
                              Container(
                                width: ScreenUtilHelper.scaleWidth(30),
                                height: ScreenUtilHelper.scaleWidth(30),
                                decoration: BoxDecoration(
                                  color: AppColors.error,
                                  borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(6)),
                                  image: const DecorationImage(
                                    image: AssetImage('assets/images/atom.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: ScreenUtilHelper.scaleWidth(25)),
                              Text(unit['name'], style: AppStyles.body20Plain),
                            ],
                          ),
                        ),
                        SizedBox(height: ScreenUtilHelper.scaleHeight(25)),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: unit['topics'].length,
                          itemBuilder: (context, topicIndex) {
                            final topic = unit['topics'][topicIndex];
                            return Padding(
                              padding: EdgeInsets.only(bottom: ScreenUtilHelper.scaleHeight(20)),
                              child: Container(
                                width: double.infinity,
                                height: ScreenUtilHelper.scaleHeight(95),
                                decoration: BoxDecoration(
                                  color: AppColors.ivory,
                                  borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(12)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(10)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(topic['title'], style: AppStyles.bodyMediumPlain),
                                      Row(
                                        children: List.generate(topic['contents'].length, (index) {
                                          return Row(
                                            children: [
                                              Text(topic['contents'][index], style: AppStyles.bodySmall),
                                              if (index < topic['contents'].length - 1)
                                                SizedBox(
                                                  height: ScreenUtilHelper.scaleHeight(16),
                                                  child: const VerticalDivider(
                                                    color: AppColors.black,
                                                    thickness: 1,
                                                    indent: 2,
                                                    endIndent: 2,
                                                  ),
                                                ),
                                            ],
                                          );
                                        }),
                                      ),
                                      SizedBox(height: ScreenUtilHelper.scaleHeight(15)),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: ScreenUtilHelper.scaleWidth(269),
                                            height: ScreenUtilHelper.scaleHeight(4),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(12)),
                                              child: LinearProgressIndicator(
                                                value: topic['progress'],
                                                backgroundColor: AppColors.ash,
                                                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.attendanceLateArrival),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: ScreenUtilHelper.scaleWidth(40)),
                                          GestureDetector(
                                            onTap: () {
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (_) => TeacherSyllableUnitScreen(
                                              //       topic: topic,
                                              //       subjectTitle: widget.syllabusTitle,
                                              //     ),
                                              //   ),
                                              // );
                                              // context.go(AppRoutes.teacherSyllabus);
                                            },
                                            child: Text("More", style: AppStyles.body13Primary),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: ScreenUtilHelper.scaleHeight(30)),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
