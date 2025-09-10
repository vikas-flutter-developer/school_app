import 'package:flutter/material.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../features/email/bloc/email_list/email_list_bloc.dart';

class EmailListItem extends StatelessWidget {
  final Email email;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onMenuTap;

  const EmailListItem({
    Key? key,
    required this.email,
    required this.isSelected,
    required this.onTap,
    required this.onMenuTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatarColor =
    email.senderInitial == 'A' ? AppColors.blackHighEmphasis : AppColors.primaryDarker;
    final avatarTextColor = AppColors.white;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.scaleWidth(16.0),
        vertical: ScreenUtilHelper.scaleHeight(6.0),
      ),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(8.0)),
        border: isSelected
            ? Border.all(color: AppColors.primaryDarker, width: ScreenUtilHelper.scaleWidth(2.0))
            : null,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.scaleWidth(16.0),
          vertical: ScreenUtilHelper.scaleHeight(8.0),
        ),
        leading: CircleAvatar(
          radius: ScreenUtilHelper.scaleRadius(22),
          backgroundColor: avatarColor,
          child: Text(
            email.senderInitial,
            style: TextStyle(
              fontSize: ScreenUtilHelper.scaleText(18),
              fontWeight: AppStyles.weight.heading,
              color: avatarTextColor,
            ),
          ),
        ),
        title: Text(
          email.senderName,
          style: TextStyle(fontWeight: AppStyles.weight.heading),
        ),
        subtitle: Text(
          email.snippet,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.stone,
            fontSize: AppStyles.size.small,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.more_vert, color: AppColors.slate),
          onPressed: onMenuTap,
        ),
        onTap: onTap,
      ),
    );
  }
}
