import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../features/sms/bloc/sms_list/sms_list_bloc.dart';

class SmsListItem extends StatelessWidget {
  final SmsConversation conversation;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const SmsListItem({
    Key? key,
    required this.conversation,
    required this.isSelected,
    required this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('EEE');
    final String displayDate = dateFormat.format(conversation.timestamp);

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.scaleWidth(16.0),
        vertical: ScreenUtilHelper.scaleHeight(8.0),
      ),
      leading: CircleAvatar(
        radius: ScreenUtilHelper.scaleRadius(25),
        backgroundColor: isSelected
            ? AppColors.primaryDarker
            : AppColors.cloud,
        child: isSelected
            ? Icon(Icons.check, color: AppColors.white, size: ScreenUtilHelper.scaleText(20))
            : Text(
          conversation.avatarInitial,
          style: TextStyle(
            fontSize: ScreenUtilHelper.scaleText(20),
            fontWeight: FontWeight.bold,
            color: AppColors.blackMediumEmphasis,
          ),
        ),
      ),
      title: Text(
        conversation.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtilHelper.scaleText(16),
        ),
      ),
      subtitle: Text(
        conversation.lastMessage,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: AppColors.stone,
          fontSize: ScreenUtilHelper.scaleText(14),
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            displayDate,
            style: TextStyle(
              color: AppColors.stone,
              fontSize: ScreenUtilHelper.scaleText(12),
            ),
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(4)),
          if (conversation.unreadCount > 0)
            CircleAvatar(
              radius: ScreenUtilHelper.scaleRadius(10),
              backgroundColor: AppColors.primaryMedium,
              child: Text(
                conversation.unreadCount.toString(),
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: ScreenUtilHelper.scaleText(10),
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else
            SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
        ],
      ),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
