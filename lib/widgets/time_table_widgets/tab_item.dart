import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String tabName;
  final bool isSelected;
  final VoidCallback onTap;

  const TabItem({
    super.key,
    required this.tabName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 0.7, color: Colors.grey),
            color: isSelected ? AppColors.primary : AppColors.transparent,
          ),
          padding: const EdgeInsets.all(5),
          child: Center(
            child: Text(
              tabName,
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.blackHighEmphasis,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
