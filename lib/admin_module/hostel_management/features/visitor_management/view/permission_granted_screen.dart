import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class PermissionGrantedScreen extends StatelessWidget {
  const PermissionGrantedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/images/edudibon_logo.png',
          width: ScreenUtilHelper.width(100),
          height: ScreenUtilHelper.height(50),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close,
                color: theme.primaryColor,
                size: ScreenUtilHelper.scaleAll(24)),
            onPressed: () => context.go(AppRoutes.hostelVisitorManagement),
          )
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
              'Permission Granted',
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: ScreenUtilHelper.height(8)),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Generate Entry Pass: Not Implemented')),
                );
              },
              child: Text(
                'Entry Pass',
                style: TextStyle(
                    color: theme.primaryColor,
                    decoration: TextDecoration.underline),
              ),
            ),
            SizedBox(height: ScreenUtilHelper.height(40)),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.hostelVisitorManagement),
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