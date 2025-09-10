import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';

class ErrorDisplay extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorDisplay({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.width(20.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: AppColors.error,
              size: ScreenUtilHelper.scaleAll(60),
            ),
            SizedBox(height: ScreenUtilHelper.height(16)),
            Text(
              'Oops! Something went wrong.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtilHelper.fontSize(24),
              ),
            ),
            SizedBox(height: ScreenUtilHelper.height(8)),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.ash,
                fontSize: ScreenUtilHelper.fontSize(16),
              ),
            ),
            if (onRetry != null) ...[
              SizedBox(height: ScreenUtilHelper.height(24)),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryDarker,
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.width(30),
                    vertical: ScreenUtilHelper.height(12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}