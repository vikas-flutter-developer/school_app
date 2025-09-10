import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../features/sms/bloc/sms_chat_bloc/sms_chat_bloc.dart';

class MessageBubble extends StatelessWidget {
  final SmsMessage message;

  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSender = message.isSender;
    final alignment = isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final color = AppColors.cloud;
    final textColor = AppColors.blackHighEmphasis;

    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(ScreenUtilHelper.scaleRadius(12)),
      topRight: Radius.circular(ScreenUtilHelper.scaleRadius(12)),
      bottomLeft: Radius.circular(isSender ? ScreenUtilHelper.scaleRadius(12) : 0),
      bottomRight: Radius.circular(isSender ? 0 : ScreenUtilHelper.scaleRadius(12)),
    );

    final DateFormat timeFormat = DateFormat('h:mm a');
    final String displayTime = timeFormat.format(message.timestamp.toLocal()).toLowerCase();

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtilHelper.scaleHeight(4.0),
        horizontal: ScreenUtilHelper.scaleWidth(8.0),
      ),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: ScreenUtilHelper.scaleWidth(MediaQuery.of(context).size.width * 0.75),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.scaleWidth(14.0),
              vertical: ScreenUtilHelper.scaleHeight(10.0),
            ),
            decoration: BoxDecoration(color: color, borderRadius: borderRadius),
            child: Text(
              message.text,
              style: TextStyle(
                color: textColor,
                fontSize: ScreenUtilHelper.scaleText(AppStyles.size.body),
              ),
            ),
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(4)),
          Padding(
            padding: EdgeInsets.only(
              left: isSender ? 0 : ScreenUtilHelper.scaleWidth(5),
              right: isSender ? ScreenUtilHelper.scaleWidth(5) : 0,
            ),
            child: Text(
              displayTime,
              style: TextStyle(
                color: AppColors.ash,
                fontSize: ScreenUtilHelper.scaleText(AppStyles.size.tiny),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
