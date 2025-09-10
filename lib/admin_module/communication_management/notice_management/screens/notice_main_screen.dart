import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
// RESPONSIVE: Import the screen utility helper
import '../../../../core/utils/screen_util_helper.dart';
import '../../../../routes/app_routes.dart';
import '../../support_management/widgets/message_app_bar.dart';
import '../bloc/notice/notice_bloc.dart';
import '../model/notice_model.dart';

class NoticesMainScreen extends StatelessWidget {
  const NoticesMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoticeBloc()..add(LoadNotices()),
      child: const _NoticesMainScreenView(),
    );
  }
}

class _NoticesMainScreenView extends StatelessWidget {
  const _NoticesMainScreenView();

  @override
  Widget build(BuildContext context) {
    // RESPONSIVE: Initialize the helper
    ScreenUtilHelper.init(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const MessageMainScreenAppBar(title: "Notice"),
      ),
      body: BlocBuilder<NoticeBloc, NoticeState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              // RESPONSIVE:
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(16.0),
                vertical: ScreenUtilHelper.height(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notices',
                        style: TextStyle(
                          // RESPONSIVE:
                          fontSize: ScreenUtilHelper.fontSize(19),
                          fontWeight: FontWeight.w600,
                          color: AppColors.graphite,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () => context.go(AppRoutes.createNewNotice),
                        icon: Icon(
                          Icons.add,
                          // RESPONSIVE:
                          size: ScreenUtilHelper.scaleAll(13),
                          color: AppColors.primaryDarker,
                        ),
                        label: Text(
                          'New',
                          style: TextStyle(
                            color: AppColors.primaryDarker,
                            // RESPONSIVE:
                            fontSize: ScreenUtilHelper.fontSize(13),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          // RESPONSIVE:
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtilHelper.width(12),
                            vertical: ScreenUtilHelper.height(6),
                          ),
                          shape: RoundedRectangleBorder(
                            // RESPONSIVE:
                            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
                            side:  BorderSide(color: AppColors.cloud),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // RESPONSIVE:
                  SizedBox(height: ScreenUtilHelper.height(20)),
                  if (state.notices.isEmpty)
                    const Center(
                      child: Text("No notices found."),
                    ),
                  ...state.notices
                      .map(
                        (notice) => Column(
                      children: [
                        _buildNoticeCard(
                          context: context,
                          notice: notice,
                          onEdit: () => context.push(AppRoutes.editNotice, extra: notice),
                          onDelete: () {
                            context.read<NoticeBloc>().add(DeleteNotice(notice.id));
                          },
                        ),
                        // RESPONSIVE:
                        SizedBox(height: ScreenUtilHelper.height(15)),
                      ],
                    ),
                  )
                      .toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoticeCard({
    required BuildContext context,
    required Notice notice,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return Container(
      // Let the parent Padding control the width
      width: double.infinity,
      decoration: BoxDecoration(
        color: notice.bgColor,
        // RESPONSIVE:
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              // RESPONSIVE:
              width: ScreenUtilHelper.width(6.0),
              decoration: BoxDecoration(
                color: notice.barColor,
                // RESPONSIVE:
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ScreenUtilHelper.radius(8.0)),
                  bottomLeft: Radius.circular(ScreenUtilHelper.radius(8.0)),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                // RESPONSIVE:
                padding: EdgeInsets.all(ScreenUtilHelper.width(12.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            notice.title,
                            style: TextStyle(
                              // RESPONSIVE:
                              fontSize: ScreenUtilHelper.fontSize(14),
                              fontWeight: FontWeight.w600,
                              color: AppColors.obsidian,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        // RESPONSIVE:
                        SizedBox(width: ScreenUtilHelper.width(8)),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              notice.status,
                              style: TextStyle(
                                // RESPONSIVE:
                                fontSize: ScreenUtilHelper.fontSize(11),
                                fontWeight: FontWeight.w400,
                                color: notice.statusColor,
                              ),
                            ),
                            if (notice.showEditDelete) ...[
                              // RESPONSIVE:
                              SizedBox(width: ScreenUtilHelper.width(8)),
                              InkWell(
                                onTap: onEdit,
                                child: Icon(
                                  Icons.edit_outlined,
                                  // RESPONSIVE:
                                  size: ScreenUtilHelper.scaleAll(13),
                                  color: AppColors.charcoal,
                                ),
                              ),
                              // RESPONSIVE:
                              SizedBox(width: ScreenUtilHelper.width(8)),
                              InkWell(
                                onTap: onDelete,
                                child: Icon(
                                  Icons.delete_outline,
                                  // RESPONSIVE:
                                  size: ScreenUtilHelper.scaleAll(18),
                                  color: AppColors.charcoal,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                    // RESPONSIVE:
                    SizedBox(height: ScreenUtilHelper.height(8)),
                    Text(
                      notice.body,
                      style: TextStyle(
                        // RESPONSIVE:
                        fontSize: ScreenUtilHelper.fontSize(14),
                        color: AppColors.charcoal,
                        height: 1.4, // Relative line height, no scaling needed
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    // RESPONSIVE:
                    SizedBox(height: ScreenUtilHelper.height(10)),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Sent To: ${notice.sentTo}',
                        style: TextStyle(
                          // RESPONSIVE:
                          fontSize: ScreenUtilHelper.fontSize(9),
                          fontWeight: FontWeight.w600,
                          color: AppColors.graphite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}