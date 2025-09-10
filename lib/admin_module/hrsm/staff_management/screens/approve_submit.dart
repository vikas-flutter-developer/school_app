import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../routes/app_routes.dart';
import '../../widgets/Custom_logo_appbar.dart';

class ApproveScreen extends StatefulWidget {
  const ApproveScreen({super.key});

  @override
  State<ApproveScreen> createState() => _ApproveScreenState();
}

class _ApproveScreenState extends State<ApproveScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        GoRouter.of(context).pushReplacement(AppRoutes.employeeProfileCreated);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomLogoAppBar(
        onBackPressed: () {
          if (context.canPop()) {
            context.pop();
          }
        },
        notificationCount: 1,
      ),
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/approve.png',
              width: 120,
            ),
            const SizedBox(height: 24),
            Text(
              'Profile Approved',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

