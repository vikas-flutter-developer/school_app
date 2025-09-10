import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:edudibon_flutter_bloc/api/avatar_api_services.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_decorations.dart';
import '../../core/utils/app_styles.dart';
import '../../core/utils/screen_util_helper.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final AvatarApiService _avatarApiService = AvatarApiService();
  String? base64Image;

  @override
  void initState() {
    super.initState();
    fetchAvatarImage();
  }

  Future<void> fetchAvatarImage() async {
    String? image = await _avatarApiService.fetchAvatar(128);
    if (image != null) {
      setState(() {
        base64Image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    List<Map<String, String>> todayNotifications = [
      {"message": "You were marked absent in today's Chemistry class.", "time": "4m ago"},
      {"message": "Your school fee payment is due on March 15th. Pay online to avoid late fees.", "time": "14m ago"},
      {"message": "The school will remain closed on March 25th due to a public holiday.", "time": "22m ago"},
    ];

    List<Map<String, String>> thisWeekNotifications = [
      {"message": "New Assignment: Your Science teacher has assigned a project on 'Solar System.'", "time": "1d ago"},
      {"message": "Your English assignment is due tomorrow. Make sure to submit it before the deadline!", "time": "2d ago"},
      {"message": "Your Mathematics exam results are now available. Check your grades in the Results section.", "time": "3d ago"},
      {"message": "Upcoming Exam Alert: Your Physics exam is scheduled for March 10th. Start preparing now!", "time": "3d ago"},
      {"message": "Attendance Alert: Your child's attendance is below 75%. Please encourage regular attendance.", "time": "2d ago"},
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
                    onPressed: () => GoRouter.of(context).pop(),
                  ),
                  SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Notifications",
                        style: AppStyles.display.copyWith(
                          fontSize: ScreenUtilHelper.scaleText(20),
                        ),
                      ),
                      SizedBox(height: ScreenUtilHelper.scaleHeight(4)),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small),
                            color: AppColors.black,
                          ),
                          children: [
                            const TextSpan(text: "You have "),
                            TextSpan(
                              text: "3 notifications",
                              style: TextStyle(
                                color: AppColors.tertiary,
                                fontWeight: AppStyles.weight.emphasis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.tune, color: AppColors.tertiary),
                    onPressed: () {},
                  ),
                ],
              ),

              SizedBox(height: ScreenUtilHelper.scaleHeight(15)),
              Text("Today", style: AppStyles.heading.copyWith(fontSize: ScreenUtilHelper.scaleText(16))),
              SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
              ...todayNotifications.map((notif) => _buildNotificationItem(notif)),

              SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
              Text("This Week", style: AppStyles.heading.copyWith(fontSize: ScreenUtilHelper.scaleText(16))),
              SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
              ...thisWeekNotifications.map((notif) => _buildNotificationItem(notif)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, String> notif) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.scaleHeight(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: AppDecorations.circleRadius,
            child: base64Image != null
                ? Image.memory(
              base64Decode(base64Image!),
              width: ScreenUtilHelper.scaleWidth(50),
              height: ScreenUtilHelper.scaleHeight(50),
              fit: BoxFit.cover,
            )
                : Container(
              width: ScreenUtilHelper.scaleWidth(50),
              height: ScreenUtilHelper.scaleHeight(50),
              color: AppColors.parchment,
            ),
          ),
          SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notif["message"]!,
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.scaleText(AppStyles.size.bodySmall),
                  ),
                ),
                SizedBox(height: ScreenUtilHelper.scaleHeight(4)),
                Text(
                  notif["time"]!,
                  style: TextStyle(
                    color: AppColors.ash,
                    fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
