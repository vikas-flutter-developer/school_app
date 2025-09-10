// notices_screen.dart
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../bloc/notice/notice_bloc.dart';

class TeacherNoticeScreen extends StatelessWidget {
  const TeacherNoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    return BlocProvider(
      create: (context) => TeacherNoticeBloc(),
      child: Scaffold(
        backgroundColor:AppColors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined,color: AppColors.blackHighEmphasis, size: ScreenUtilHelper.scaleWidth(24)),
            onPressed: () => GoRouter.of(context).pop(),
          ),
          title: Text(
            'Notices',
            style: TextStyle(fontSize: ScreenUtilHelper.scaleText(20)),
          ),
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
          elevation: 0,
        ),
        body: BlocBuilder<TeacherNoticeBloc, NoticeState>(
          builder: (context, state) {
            if (state.status == NoticeStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == NoticeStatus.failure) {
              return Center(child: Text('Error: ${state.error}'));
            }
            if (state.notices.isEmpty) {
              return const Center(child: Text('No notices available.'));
            }

            return ListView(
              padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(12.0)),
              children: [
                Text(
                  "Today's",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtilHelper.scaleText(20),
                  ),
                ),
                SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
                ...state.notices
                    .map((notice) => NoticeCard(notice: notice))
                    .toList(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class NoticeCard extends StatelessWidget {
  final TeacherNotice notice;

  const NoticeCard({Key? key, required this.notice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd/MM/yy');
    final String displayDate = dateFormat.format(notice.date);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: notice.colorIndicator,width: 8)),
          borderRadius: BorderRadius.circular(16),
          color: notice.colorIndicator.withAlpha(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      notice.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtilHelper.scaleText(16),
                      ),
                    ),
                  ),
                  Text(
                    displayDate,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.stone,
                      fontSize: ScreenUtilHelper.scaleText(12),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
              Text(
                notice.content,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.stone,
                  fontSize: ScreenUtilHelper.scaleText(14),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    context.read<TeacherNoticeBloc>().add(MarkNoticeAsRead(notice.id));
                    _showNoticeDetailDialog(context, notice);
                  },
                  child: Text(
                    'Read',
                    style: TextStyle(
                      color: notice.isRead ? Colors.grey : Theme.of(context).primaryColor,
                      fontWeight: AppStyles.weight.heading,
                      fontSize: ScreenUtilHelper.scaleText(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNoticeDetailDialog(BuildContext context, TeacherNotice notice) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            notice.title,
            style: TextStyle(fontSize: ScreenUtilHelper.scaleText(18)),
          ),
          content: SingleChildScrollView(
            child: Text(
              notice.content,
              style: TextStyle(fontSize: ScreenUtilHelper.scaleText(14)),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Close',
                style: TextStyle(fontSize: ScreenUtilHelper.scaleText(14)),
              ),
              onPressed: () {
                GoRouter.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
