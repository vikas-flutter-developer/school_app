import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart';

class RecruitmentScreen extends StatelessWidget {
  const RecruitmentScreen({super.key});

  static final List<Map<String, dynamic>> scheduledInterviews = [
    {
      'title': 'Math Teacher - Secondary School',
      'candidates': [
        {'name': 'Kajal Pradhan', 'time': '12:00pm'},
        {'name': 'Shikha Singh', 'time': '02:00pm'},
        {'name': 'Mahesh Yadav', 'time': '03:30pm'},
      ]
    },
    {'title': 'English Teacher - Primary School', 'candidates': []},
    {'title': 'Non Teaching ', 'candidates': []},
  ];

  static final List<Map<String, dynamic>> trainings = [
    {
      'title': 'Non-Teaching Staff',
      'sessions': [
        {'name': 'Session 1', 'time': '09:00am'},
        {'name': 'Session 2', 'time': '11:00am'},
      ],
    },
    {
      'title': 'Math Bootcamp',
      'sessions': [
        {'name': 'Intro', 'time': '01:00pm'},
      ],
    },
    {
      'title': 'Administration',
      'sessions': [
        {'name': 'Orientation', 'time': '03:00pm'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context),
      child: Builder(builder: (context) {
        ScreenUtilHelper.init(context);
    
        Widget buildCountBox(String count, String label) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(4)),
              padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(12)),
              ),
              child: Column(
                children: [
                  Text(
                    count,
                    style: AppStyles.bodyMedium.copyWith(
                      fontSize: ScreenUtilHelper.scaleText(18),
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(4)),
                  Text(
                    label,
                    style: AppStyles.chartLabel.copyWith(color: AppColors.black),
                  ),
                ],
              ),
            ),
          );
        }
    
        List<Widget> buildScheduledInterviewsList() {
          List<Widget> interviewWidgets = [];
          for (var interview in scheduledInterviews) {
            interviewWidgets.add(
              Container(
                margin: EdgeInsets.symmetric(vertical: ScreenUtilHelper.scaleHeight(8)),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(12)),
                ),
                child: ExpansionTile(
                  title: Text(
                    interview['title']!,
                    style: AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
                  ),
                  children: (interview['candidates'] as List<dynamic>).map((candidate) {
                    final candidateMap = candidate as Map<String, String>;
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.scaleWidth(16),
                        vertical: ScreenUtilHelper.scaleHeight(4),
                      ),
                      padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(12)),
                      decoration: BoxDecoration(
                        color: Color(0xff6E69C5),
                        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(8)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            candidateMap['name']!,
                            style: AppStyles.bodyMedium.copyWith(color: AppColors.white),
                          ),
                          Text(
                            candidateMap['time']!,
                            style: AppStyles.bodySmall.copyWith(color: AppColors.white),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          }
          return interviewWidgets;
        }
    
        List<Widget> buildTrainingsList() {
          List<Widget> trainingWidgets = [];
          for (var training in trainings) {
            trainingWidgets.add(
              Container(
                margin: EdgeInsets.symmetric(vertical: ScreenUtilHelper.scaleHeight(8)),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(12)),
                ),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.scaleWidth(16),
                    vertical: ScreenUtilHelper.scaleHeight(4),
                  ),
                  title: Text(
                    training['title']!,
                    style: AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
                  ),
                  children: (training['sessions'] as List<dynamic>).map((session) {
                    final sessionMap = session as Map<String, String>;
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.scaleWidth(16),
                        vertical: ScreenUtilHelper.scaleHeight(4),
                      ),
                      padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(12)),
                      decoration: BoxDecoration(
                        color: Color(0xff6E69C5),
                        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(8)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            sessionMap['name']!,
                            style: AppStyles.bodyMedium.copyWith(color: AppColors.white),
                          ),
                          Text(
                            sessionMap['time']!,
                            style: AppStyles.bodySmall.copyWith(color: AppColors.white),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          }
          return trainingWidgets;
        }
    
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.scaleWidth(16),
              vertical: ScreenUtilHelper.scaleHeight(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(15)),
                  child: Row(
                    children: [
                      SizedBox(height: 52),
                      Image.asset(
                        'assets/images/edudibon1.png',
                        height: ScreenUtilHelper.scaleHeight(30),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.notifications_none_outlined,
                        color: AppColors.blackHighEmphasis,
                        size: ScreenUtilHelper.scaleWidth(24),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => GoRouter.of(context).pop(),
                      child: Icon(Icons.arrow_back_ios_new, size: ScreenUtilHelper.width(20)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(16)),
                      child: Text(
                        'Recruitment',
                        style: AppStyles.bodySmall.copyWith(fontSize: ScreenUtilHelper.scaleText(16)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
    
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffF1F1F1),
                    borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(12)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(8)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search.....',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: AppColors.blackHighEmphasis, size: ScreenUtilHelper.scaleWidth(20)),
                      suffixIcon: Icon(Icons.mic, color: AppColors.blackHighEmphasis, size: ScreenUtilHelper.scaleWidth(20)),
                    ),
                  ),
                ),
    
                SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
    
                // Filter Row
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.parchment,
                        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(12)),
                      ),
                      padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(8)),
                      child: Icon( Icons.filter_alt_outlined,
                        color: AppColors.slate,
                        size: ScreenUtilHelper.width(20),),
                    ),
                    SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(12)),
                        decoration: BoxDecoration(
                          color: AppColors.parchment,
                          borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(12)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: 'Teaching',
                            icon: Icon(Icons.keyboard_arrow_down, color: AppColors.black),
                            items: <String>['Teaching', 'Non-Teach', 'Admin']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {},
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(12)),
                        decoration: BoxDecoration(
                          color: AppColors.parchment,
                          borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(12)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: 'Date',
                            icon: Icon(Icons.keyboard_arrow_down, color: AppColors.black),
                            items: <String>['Date', 'Name']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    
                SizedBox(height: ScreenUtilHelper.scaleHeight(24)),
    
                // Counts Section
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffEDECF8),
                    borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(12)),
                  ),
                  padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildCountBox('05', 'Teaching'),
                      buildCountBox('02', 'Non Teaching'),
                      buildCountBox('0', 'Admin'),
                    ],
                  ),
                ),
    
                SizedBox(height: ScreenUtilHelper.scaleHeight(24)),
    
                // Scheduled Interviews Section
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff93A5E8),
                    borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(12)),
                  ),
                  padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: ScreenUtilHelper.scaleWidth(4),
                          right: ScreenUtilHelper.scaleWidth(139),
                        ),
                        child: Text(
                          "Scheduled Interviews",
                          style: AppStyles.heading,
                        ),
                      ),
                      ...buildScheduledInterviewsList(),
                    ],
                  ),
                ),
    
                SizedBox(height: ScreenUtilHelper.scaleHeight(24)),
    
                // Trainings Section
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff93A5E8),
                    borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(12)),
                  ),
                  padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: ScreenUtilHelper.scaleWidth(4),
                          right: ScreenUtilHelper.scaleWidth(139),
                        ),
                        child: Text(
                          "Trainings",
                          style: AppStyles.heading,
                        ),
                      ),
                      ...buildTrainingsList(),
                    ],
                  ),
                ),
    
                SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment),
                label: 'Feed',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'My Account',
              ),
            ],
            currentIndex: 0,
            selectedItemColor: AppColors.primaryMedium,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
          ),
        );
      }),
    );
  }
}