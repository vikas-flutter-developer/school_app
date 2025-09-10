import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../bloc/Attendance_bloc.dart';
import '../bloc/Attendance_event.dart';
import '../bloc/Attendance_state.dart';

class StaffAttendanceScreen extends StatelessWidget {
  const StaffAttendanceScreen({super.key});

  Color statusColor(String statusLetter) {
    switch (statusLetter) {
      case "P":
        return AppColors.ptmStatus;
      case "A":
        return AppColors.error;
      case "L":
        return AppColors.warningAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AttendanceBloc()..add(LoadAttendance()),
      child: Scaffold(
        // --- CHANGED: Set a light grey background for the whole screen ---
        // Using a common light grey color. Replace with your AppColor if you have one.
        backgroundColor:AppColors.white ,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // This top section should be on a colored background, so we wrap it
              Container(
                color: AppColors.white, // The top bar has a white background in the screenshot
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtilHelper.scaleWidth(18), vertical: ScreenUtilHelper.scaleHeight(10)),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/edudibon1.png',
                            height: ScreenUtilHelper.scaleHeight(25),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.notifications_none_outlined,
                            color: AppColors.blackHighEmphasis,
                            size: ScreenUtilHelper.scaleWidth(26),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(16)),
                      child: Row(
                        children: [
                          GestureDetector(onTap: () => GoRouter.of(context).pop(), child: Icon(Icons.arrow_back_ios_new, size: ScreenUtilHelper.width(20))),
                          SizedBox(width: ScreenUtilHelper.scaleWidth(16)),
                          Text(
                            'Attendance',
                            style: AppStyles.small.copyWith(fontSize: ScreenUtilHelper.scaleText(16), //fontWeight: AppStyles.size.small),
                          ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(12)),
                  ],
                ),
              ),

              // Search and Filter section remains on the main grey background
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(16)),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search.....",
                    prefixIcon: Icon(Icons.search,
                        color: AppColors.blackHighEmphasis, size: ScreenUtilHelper.scaleWidth(24)),
                    suffixIcon: Icon(Icons.mic_none,
                        color: AppColors.blackHighEmphasis, size: ScreenUtilHelper.scaleWidth(24)),
                    fillColor: AppColors.parchment,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.scaleHeight(1)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(15)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(14)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(16)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(ScreenUtilHelper.scaleHeight(8)),
                      decoration: BoxDecoration(
                        color: AppColors.parchment,
                        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(10)),
                      ),
                      child: Icon(
                        Icons.filter_alt_outlined,
                        color: AppColors.slate,
                        size: ScreenUtilHelper.width(20),
                      ),
                    ),
                    SizedBox(width: ScreenUtilHelper.scaleWidth(12)),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: "Teaching",
                        items: const [
                          DropdownMenuItem(value: "Teaching", child: Text("Teaching")),
                          DropdownMenuItem(value: "Admin", child: Text("Admin")),
                        ],
                        onChanged: (val) {},
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.parchment,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: ScreenUtilHelper.scaleWidth(12),
                              vertical: ScreenUtilHelper.scaleHeight(8)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(10)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtilHelper.scaleWidth(12)),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: "Date",
                        items: const [
                          DropdownMenuItem(value: "Date", child: Text("Date")),
                        ],
                        onChanged: (val) {},
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.parchment,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: ScreenUtilHelper.scaleWidth(12),
                              vertical: ScreenUtilHelper.scaleHeight(8)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(10)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
              Center(
                child: Text(
                  '19/03/25',
                  style: AppStyles.small
                      .copyWith(fontWeight: FontWeight.w600, fontSize: ScreenUtilHelper.scaleText(14)),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(8)),

              Expanded(
                child: BlocBuilder<AttendanceBloc, AttendanceState>(
                  builder: (context, state) {
                    if (state is AttendanceLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is AttendanceLoaded) {
                      final attendance = state.attendanceList;
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(16)),
                        itemCount: attendance.length,
                        itemBuilder: (context, index) {
                          final record = attendance[index];
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: ScreenUtilHelper.scaleHeight(4)),
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtilHelper.scaleWidth(11),
                                vertical: ScreenUtilHelper.scaleHeight(11)
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    record.name,
                                    style: AppStyles.bodyMedium.copyWith(color: AppColors.black, fontSize: ScreenUtilHelper.scaleText(12)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 18),
                                Expanded(
                                  child: Text(
                                    record.role,
                                    style: AppStyles.bodyMedium.copyWith(color: AppColors.black, fontSize: ScreenUtilHelper.scaleText(12)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                Container(
                                  width: ScreenUtilHelper.scaleWidth(28),
                                  height: ScreenUtilHelper.scaleWidth(28),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: statusColor(record.status),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    record.status,
                                    style: AppStyles.bodyBold.copyWith(
                                        fontSize: ScreenUtilHelper.scaleText(15), color: AppColors.white),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('Something went wrong!'));
                    }
                  },
                ),
              ),

// ... बाकी कोड वैसा ही रहेगा
            ],
          ),
        ),
      ),
    );
  }
}