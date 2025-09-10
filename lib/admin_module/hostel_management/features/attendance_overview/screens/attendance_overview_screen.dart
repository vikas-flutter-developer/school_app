 import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../../../routes/app_routes.dart';
import '../bloc/attendance_overview/attendance_overview_bloc.dart';
import '../models/room_model.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/room_header_widget.dart';
import '../widgets/search_filter_bar_widget.dart';
import '../widgets/section_divider_widget.dart';
import '../widgets/student_list_item_widget.dart';

class AttendanceOverviewScreen extends StatelessWidget {
  const AttendanceOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Scaffold(
      appBar: const CommonBar(),
      body: BlocBuilder<AttendanceOverviewBloc, AttendanceOverviewState>(
        builder: (context, state) {
          if (state is AttendanceOverviewLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AttendanceOverviewLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SearchFilterBarWidget(),
                  SizedBox(height: ScreenUtilHelper.height(20)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.width(16.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: ScreenUtilHelper.height(41),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                ScreenUtilHelper.radius(6)),
                            color: AppColors.ivory,
                          ),
                          child: Center(
                            child: Text(
                              "Daily Attendance",
                              style: AppStyles.headingRegular
                            ),
                          ),
                        ),
                        SizedBox(height: ScreenUtilHelper.height(20)),
                        ..._buildRoomSections(context, state.rooms),
                        SizedBox(height: ScreenUtilHelper.height(20)),
                        const Divider(),
                        SizedBox(height: ScreenUtilHelper.height(50)),
                        const Divider(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is AttendanceOverviewError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("Please load data."));
        },
      ),
    );
  }

  List<Widget> _buildRoomSections(
      BuildContext context, List<RoomModel> rooms) {
    List<Widget> sections = [];
    for (int i = 0; i < rooms.length; i++) {
      final room = rooms[i];
      sections.add(
        RoomHeaderWidget(
          roomNumber: room.roomNumber,
          onTap: () =>context.push(AppRoutes.hostelAttendanceRoomDetails,extra: room.roomNumber),
        ),
      );
      sections.addAll(
        room.students
            .map((student) => StudentListItemWidget(student: student))
            .toList(),
      );
      if (i < rooms.length - 1) {
        sections.add(const SectionDividerWidget());
      }
    }
    return sections;
  }
}