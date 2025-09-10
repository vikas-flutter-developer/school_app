import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    if (totalPages <= 1) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(16.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed:
            currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
          ),
          for (int i = 1; i <= totalPages; i++)
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(4.0)),
              child: InkWell(
                onTap: () => onPageChanged(i),
                child: CircleAvatar(
                  radius: ScreenUtilHelper.scaleAll(16),
                  backgroundColor: i == currentPage
                      ? Theme.of(context).primaryColor
                      : AppColors.cloud,
                  child: Text(
                    '$i',
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.fontSize(14),
                      color:
                      i == currentPage ? AppColors.white : AppColors.black,
                    ),
                  ),
                ),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: currentPage < totalPages
                ? () => onPageChanged(currentPage + 1)
                : null,
          ),
        ],
      ),
    );
  }
}