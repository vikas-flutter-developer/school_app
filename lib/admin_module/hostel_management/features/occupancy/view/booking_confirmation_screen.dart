import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../../../routes/app_routes.dart';
import '../bloc/occupancy_bloc.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final String roomId;
  final String studentName;

  const BookingConfirmationScreen(
      {super.key, required this.roomId, required this.studentName});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: theme.primaryColor,
                size: ScreenUtilHelper.scaleAll(22)),
            onPressed: () => context.pop()),
        title: Image.asset(
          'assets/images/edudibon_logo.png',
          width: ScreenUtilHelper.width(100),
          height: ScreenUtilHelper.height(50),
        ),
      ),
      body: Column(
        children: [
          _buildStudentInfo(context, studentName, roomId),
          const Spacer(),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(ScreenUtilHelper.width(20)),
            color: theme.colorScheme.surface,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Are you sure?',
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                SizedBox(height: ScreenUtilHelper.height(20)),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => context.pop(),
                        style: OutlinedButton.styleFrom(
                          minimumSize:
                          Size(0, ScreenUtilHelper.height(48)),
                          side: BorderSide(color: theme.primaryColor),
                        ),
                        child: const Text('No'),
                      ),
                    ),
                    SizedBox(width: ScreenUtilHelper.width(16)),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<OccupancyBloc>().add(ConfirmBooking(
                              roomId: roomId, studentId: "someStudentId"));
                          context.go(AppRoutes.hostelSeatConfirmed);
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize:
                            Size(0, ScreenUtilHelper.height(48))),
                        child: const Text('Yes'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStudentInfo(
      BuildContext context, String studentName, String roomId) {
    final theme = Theme.of(context);
    final student = HostelStudent(
        id: "101-3",
        name: studentName,
        email: "aditisehgal@gmail.com",
        phone: "+91 78869 56775",
        department: "Civil Engineering",
        year: "1st Year",
        photoUrl: 'https://via.placeholder.com/150/FFC107/000000?Text=AS');

    return Card(
      elevation: 0,
      color: AppColors.white,
      margin: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(student.id,
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.primaryColor,
                          fontSize: ScreenUtilHelper.fontSize(12))),
                  Text(student.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtilHelper.fontSize(16))),
                  Text(student.email,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontSize: ScreenUtilHelper.fontSize(14))),
                  Text(student.phone,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontSize: ScreenUtilHelper.fontSize(14))),
                  Text(student.department,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontSize: ScreenUtilHelper.fontSize(14))),
                  Text(student.year,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontSize: ScreenUtilHelper.fontSize(14))),
                ],
              ),
            ),
            SizedBox(width: ScreenUtilHelper.width(16)),
            Column(
              children: [
                CircleAvatar(
                  radius: ScreenUtilHelper.radius(40),
                  backgroundImage: student.photoUrl != null
                      ? NetworkImage(student.photoUrl!)
                      : null,
                  child: student.photoUrl == null
                      ? Icon(Icons.person, size: ScreenUtilHelper.scaleAll(40))
                      : null,
                ),
                SizedBox(height: ScreenUtilHelper.height(8)),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.width(10),
                        vertical: ScreenUtilHelper.height(5)),
                    side:
                    BorderSide(color: theme.primaryColor.withOpacity(0.5)),
                  ),
                  child: Text('Receipt',
                      style:AppStyles.small),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SeatConfirmedScreen extends StatelessWidget {
  const SeatConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: Icon(Icons.close,
                  color: theme.primaryColor,
                  size: ScreenUtilHelper.scaleAll(24)),
              onPressed: () => context.go(AppRoutes.hostelManagement))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle,
                color: AppColors.tertiaryAccentDark,
                size: ScreenUtilHelper.scaleAll(100)),
            SizedBox(height: ScreenUtilHelper.height(24)),
            Text(
              'Seat is confirmed',
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: ScreenUtilHelper.height(8)),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Generate Receipt: Not Implemented')),
                );
              },
              child: Text(
                'Generate Confirmation receipt',
                style: TextStyle(
                    color: theme.primaryColor,
                    decoration: TextDecoration.underline),
              ),
            ),
            SizedBox(height: ScreenUtilHelper.height(40)),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.hostelManagement),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.width(50),
                      vertical: ScreenUtilHelper.height(15))),
              child: const Text('Done'),
            )
          ],
        ),
      ),
    );
  }
}