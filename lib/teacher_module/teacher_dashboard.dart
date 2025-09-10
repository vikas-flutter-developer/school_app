import 'package:edudibon_flutter_bloc/cubit/homepage_cubit.dart';
import 'package:edudibon_flutter_bloc/cubit/homepage_state.dart';
import 'package:edudibon_flutter_bloc/customs/banner.dart';
import 'package:edudibon_flutter_bloc/customs/cards.dart';
import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/screen_util_helper.dart';
import '../student_module/tab_bars&notifications/notification_screen.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  _TeacherDashboardState createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  bool hasNotification = true;

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    return BlocProvider(
      create:
          (context) =>
              HomepageCubit()..updateHomeContent(
                "Start Your Journey With Us!",
                [],
                "Hackathon: March 30, 2025",
                "80% of students have completed their courses.",
              ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          titleSpacing: 0.0,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(16)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/edudibon_logo.png',
                  height: ScreenUtilHelper.height(30),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: ()=>context.push(AppRoutes.notifications),
                  child: Image.asset(
                    'assets/images/notification.png',
                    height: ScreenUtilHelper.height(24),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: AppColors.white,
          // elevation: 1.0,
        ),
        body: SafeArea(
          child: BlocBuilder<HomepageCubit, HomepageState>(
            builder: (context, state) {
              // Define titles and images for each card
              List<Map<String, String>> services = [
                {
                  "title": "Attendance & Performance",
                  "image": "assets/images/attendence.png",
                  "route": AppRoutes.attendancePerformance
                },
                {
                  "title": "Assignment & Study Materials",
                  "image": "assets/images/assignment.png",
                  "route": AppRoutes.assignmentStudentMaterial
                },

                {
                  "title": "Today's Schedule & Event",
                  "image": "assets/images/timetable.png",
                  "route": AppRoutes.scheduleEvents
                },
                {
                  "title": "Announcement & Communication",
                  "image": "assets/images/timetable.png",
                  "route": AppRoutes.teacherCommunication
                },
                {
                  "title": "Exam Insights & Reports",
                  "image": "assets/images/timetable.png",
                  "route": AppRoutes.examInsightsReports
                },
                {
                  "title": "Fees & payment status",
                  "image": "assets/images/fee.png",
                  "route": AppRoutes.feePaymentStatus
                },
                {
                  "title": "Inventory Management",
                  "image": "assets/images/timetable.png",
                  "route": AppRoutes.serviceList
                },
                {
                  "title": "Raise Tickets",
                  "image": "assets/images/studymaterial.png",
                  "route": AppRoutes.ticketsList
                },
                {
                  "title": "Leave Overview",
                  "image": "assets/images/syllabus.png",
                  "route": AppRoutes.leaveOverview
                },
              ];

              return SingleChildScrollView(
                // padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Icon(Icons.mic, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    BannerWidget(
                      imagePath: 'assets/images/teacherdashboard2.png',
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Banner
                        const Text(
                          "Explore Services",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Service Cards
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: services.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.85,
                                ),
                            itemBuilder: (context, index) {
                              final service = services[index];
                              return CustomCard(
                                imagePath: service["image"]!,
                                title: service["title"]!,
                                fitImage: BoxFit.cover,
                                onTap: () => context.push(services[index]["route"]!),
                              );
                            },
                          ),
                        ),
                        //const SizedBox(height: 20),
                        //
                        // const Text(
                        //   "Upcoming Events",
                        //   style: TextStyle(
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BannerWidget(
                            imagePath: 'assets/images/teacherdashboard1.png',
                          ),
                        ),
                        const SizedBox(height: 20),

                        // const Text(
                        //   "Summary Report",
                        //   style: TextStyle(
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // const SizedBox(height: 10),
                        // BannerWidget(imagePath: 'assets/images/b3.png'),
                        // const SizedBox(height: 20),
                      ],
                    ),
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
