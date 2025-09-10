import 'package:edudibon_flutter_bloc/cubit/homepage_cubit.dart';
import 'package:edudibon_flutter_bloc/cubit/homepage_state.dart';
import 'package:edudibon_flutter_bloc/customs/banner.dart';
import 'package:edudibon_flutter_bloc/customs/cards.dart';
import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/app_styles.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_decorations.dart';
import '../../core/utils/screen_util_helper.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  StudentHomePageState createState() => StudentHomePageState();
}

class StudentHomePageState extends State<StudentHomePage> {
  bool hasNotification = true;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => HomepageCubit()
        ..updateHomeContent(
          "Upcoming Sports Tournament!",
          [],
          "Hackathon: March 30, 2025",
          "80% of students have completed their courses.",
        ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: BlocBuilder<HomepageCubit, HomepageState>(
            builder: (context, state) {
              List<Map<String, String>> services = [
                {"title": "Academics", "image": "assets/images/academics.png",'route':AppRoutes.academics},
                {"title": "Attendance", "image": "assets/images/attendence.png",'route':AppRoutes.attendance},
                {"title": "Bus Tracking", "image": "assets/images/bustracking.png",'route':AppRoutes.busTracking},
                {"title": "Assignment & Home work", "image": "assets/images/assignment.png",'route':AppRoutes.assignmentNHomework},
                {"title": "Time table", "image": "assets/images/timetable.png",'route':AppRoutes.timetable},
                {"title": "Fees & payment status", "image": "assets/images/fee.png",'route':AppRoutes.feeNPayment},
                {"title": "study Material", "image": "assets/images/studymaterial.png",'route':AppRoutes.studyMaterials},
                {"title": "Syllabus", "image": "assets/images/syllabus.png",'route':AppRoutes.syllabus},
                {"title": "Calendar", "image": "assets/images/calender.png",'route':AppRoutes.calender},
              ];
              return SingleChildScrollView(
                padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🔝 Logo and notification
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/edudibon.png',
                          width: ScreenUtilHelper.scaleWidth(100),
                          height: ScreenUtilHelper.scaleHeight(50),
                        ),
                        InkWell(
                          onTap: ()=>AppRoutes.notifications,
                          child: Image.asset(
                            'assets/images/notification.png',
                            width: ScreenUtilHelper.scaleWidth(30),
                            height: ScreenUtilHelper.scaleHeight(30),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: ScreenUtilHelper.scaleHeight(15)),

                    /// 🔍 Search bar
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(10)),
                    //   decoration: BoxDecoration(
                    //     color: AppColors.parchment,
                    //     borderRadius: AppDecorations.normalRadius,
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       const Icon(Icons.search, color: AppColors.ash),
                    //       SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
                    //       Expanded(
                    //         child: TextField(
                    //           style: TextStyle(fontSize: ScreenUtilHelper.scaleText(14)),
                    //           decoration: const InputDecoration(
                    //             hintText: "Search",
                    //             border: InputBorder.none,
                    //           ),
                    //         ),
                    //       ),
                    //       const Icon(Icons.mic, color: AppColors.ash),
                    //     ],
                    //   ),
                    // ),
                    /// 🔍 Search bar (Updated to prevent overflow)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(10),
                      vertical: ScreenUtilHelper.scaleHeight(8)),
                      decoration: BoxDecoration(
                        color: AppColors.parchment,
                        borderRadius: AppDecorations.normalRadius,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: AppColors.ash),
                          SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
                          Expanded(
                            child: TextField(
                              style: TextStyle(fontSize: ScreenUtilHelper.scaleText(14)),
                              decoration: const InputDecoration(
                                hintText: "Search",
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          const Icon(Icons.mic, color: AppColors.ash),
                        ],
                      ),
                    ),

                    SizedBox(height: ScreenUtilHelper.scaleHeight(20)),

                    /// 🏁 Banner
                    BannerWidget(imagePath: 'assets/images/b1.png'),

                    SizedBox(height: ScreenUtilHelper.scaleHeight(20)),

                    Text("Explore Services", style: AppStyles.heading.copyWith(fontSize: ScreenUtilHelper.scaleText(18))),

                    SizedBox(height: ScreenUtilHelper.scaleHeight(10)),

                    /// 🧩 Services Grid
                    GridView.builder(
                      itemCount: services.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: ScreenUtilHelper.scaleWidth(10),
                        mainAxisSpacing: ScreenUtilHelper.scaleHeight(10),
                        childAspectRatio: 0.85,
                      ),
                      itemBuilder: (context, index) {
                        final service = services[index];
                        return CustomCard(
                          imagePath: service["image"]!,
                          title: service["title"]!,
                          fitImage: BoxFit.cover,
                          onTap: () => context.push(services[index]['route']!),
                        );
                      },
                    ),

                    SizedBox(height: ScreenUtilHelper.scaleHeight(20)),

                    Text("Upcoming Events", style: AppStyles.heading.copyWith(fontSize: ScreenUtilHelper.scaleText(18))),

                    SizedBox(height: ScreenUtilHelper.scaleHeight(10)),

                    BannerWidget(imagePath: 'assets/images/b2.png'),

                    SizedBox(height: ScreenUtilHelper.scaleHeight(20)),

                    Text("Summary Report", style: AppStyles.heading.copyWith(fontSize: ScreenUtilHelper.scaleText(18))),

                    SizedBox(height: ScreenUtilHelper.scaleHeight(10)),

                    BannerWidget(imagePath: 'assets/images/b3.png'),

                    SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
