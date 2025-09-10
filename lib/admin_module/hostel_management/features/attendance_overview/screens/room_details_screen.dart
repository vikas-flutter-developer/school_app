import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../bloc/room_details/room_details_bloc.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/student_card_widget.dart';

class AttendanceRoomDetailsScreen extends StatelessWidget {
  final String roomNumber;

  const AttendanceRoomDetailsScreen({super.key, required this.roomNumber});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Scaffold(
      appBar: const CommonBar(),
      body: BlocBuilder<AttendanceRoomDetailsBloc, RoomDetailsState>(
        builder: (context, state) {
          if (state is RoomDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is RoomDetailsLoaded) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(16.0)),
              child: Column(
                children: [
                  SizedBox(height: ScreenUtilHelper.height(20)),
                  Container(
                    width: double.infinity,
                    height: ScreenUtilHelper.height(41),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(ScreenUtilHelper.radius(6)),
                      color: AppColors.ivory,
                    ),
                    child: Center(
                      child: Text(
                        "Room Details",
                        style: AppStyles.headingRegular
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(20)),
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.students.length,
                      itemBuilder: (context, index) {
                        return StudentCardWidget(
                          studentData: state.students[index],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: ScreenUtilHelper.height(20)),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is RoomDetailsError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("Please load room details."));
        },
      ),
    );
  }
}