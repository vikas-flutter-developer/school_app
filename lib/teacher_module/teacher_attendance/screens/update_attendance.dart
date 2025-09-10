import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart' show AppStyles;
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/widgets/student_card.dart' show StudentCard;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart'; // ScreenUtilHelper
import 'package:go_router/go_router.dart';

import '../bloc/update_attendance_bloc/update_attendance_bloc.dart';

class UpdateAttendanceScreen extends StatelessWidget {
  const UpdateAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // ScreenUtilHelper

    return BlocProvider(
      create: (context) => UpdateAttendanceBloc()
        ..add(
          LoadStudents(
            selectedClass: 'Class XA',
            selectedDate: DateTime(2025, 1, 22),
          ),
        ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/edudibon.png',
                height: ScreenUtilHelper.height(30), // ScreenUtilHelper
                fit: BoxFit.contain,
              ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_none,
                      color: AppColors.ash,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: ScreenUtilHelper.height(1), // ScreenUtilHelper
                        right: ScreenUtilHelper.width(5), // ScreenUtilHelper
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                      width: ScreenUtilHelper.width(15), // ScreenUtilHelper
                      height: ScreenUtilHelper.height(15), // ScreenUtilHelper
                      child: Center(
                        child: Text(
                          "3",
                          style: TextStyle(
                            fontSize: ScreenUtilHelper.fontSize(10), // ScreenUtilHelper
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: BlocBuilder<UpdateAttendanceBloc, UpdateAttendanceState>(
          builder: (context, state) {
            if (state is UpdateAttendanceInitial || state is UpdateAttendanceLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UpdateAttendanceError) {
              return Center(child: Text(state.message));
            } else if (state is UpdateAttendanceLoaded) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(left: ScreenUtilHelper.width(8)), // ScreenUtilHelper
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.blackMediumEmphasis,
                                size: 20,
                              ),
                              onPressed: ()=>GoRouter.of(context).pop(),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              splashRadius: 20,
                            ),
                            SizedBox(width: ScreenUtilHelper.width(8)), // ScreenUtilHelper
                            Text(
                              'Update Attendance',
                              style: TextStyle(
                                fontSize: ScreenUtilHelper.fontSize(16), // ScreenUtilHelper
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.width(15.0), // ScreenUtilHelper
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: ScreenUtilHelper.width(160), // ScreenUtilHelper
                            height: ScreenUtilHelper.height(44), // ScreenUtilHelper
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtilHelper.width(12.0), // ScreenUtilHelper
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primaryContrast,
                              ),
                              borderRadius: BorderRadius.circular(
                                ScreenUtilHelper.radius(8.0), // ScreenUtilHelper
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: state.selectedClass,
                                isExpanded: true,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.blackMediumEmphasis,
                                ),
                                elevation: 1,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: ScreenUtilHelper.fontSize(14), // ScreenUtilHelper
                                ),
                                onChanged: (String? newValue) {
                                  context.read<UpdateAttendanceBloc>().add(
                                    SelectClass(newValue!),
                                  );
                                },
                                items: <String>[
                                  'Class XA',
                                  'Class XB',
                                  'Class XC',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(width: ScreenUtilHelper.width(12)), // ScreenUtilHelper
                          InkWell(
                            onTap: () => _selectDate(context, state.selectedDate),
                            child: Container(
                              width: ScreenUtilHelper.width(160), // ScreenUtilHelper
                              height: ScreenUtilHelper.height(44), // ScreenUtilHelper
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtilHelper.width(12.0), // ScreenUtilHelper
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.primaryContrast,
                                ),
                                borderRadius: BorderRadius.circular(
                                  ScreenUtilHelper.radius(8.0), // ScreenUtilHelper
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _formatDate(state.selectedDate),
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: ScreenUtilHelper.fontSize(14), // ScreenUtilHelper
                                    ),
                                  ),
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: AppColors.blackMediumEmphasis,
                                    size: ScreenUtilHelper.scaleAll(20), // ScreenUtilHelper
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(25)), // ScreenUtilHelper
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.width(30.0), // ScreenUtilHelper
                      ),
                      child: SizedBox(
                        width: ScreenUtilHelper.width(334), // ScreenUtilHelper
                        height: ScreenUtilHelper.height(110), // ScreenUtilHelper
                        child: GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2.2,
                          children: [
                            _buildActionButton(
                              'Mark\nall Present',
                              AppColors.mintGreen,
                                  () {
                                context.read<UpdateAttendanceBloc>().add(
                                  const BulkUpdateStatus('Present'),
                                );
                              },
                            ),
                            _buildActionButton(
                              'Mark\nall Late Arrival',
                              AppColors.limeGreen,
                                  () {
                                context.read<UpdateAttendanceBloc>().add(
                                  const BulkUpdateStatus('Late'),
                                );
                              },
                            ),
                            _buildActionButton(
                              'Mark\nall Absent',
                              AppColors.paymentLeadingBg,
                                  () {
                                context.read<UpdateAttendanceBloc>().add(
                                  const BulkUpdateStatus('Absent'),
                                );
                              },
                            ),
                            _buildActionButton(
                              'Mark\nall Outdoor',
                              AppColors.secondaryLighter,
                                  () {},
                            ),
                            _buildActionButton(
                              'Mark\nall Half Day',
                              AppColors.secondaryAccentLight,
                                  () {},
                            ),
                            _buildActionButton(
                              'Mark\nall Holiday',
                              AppColors.pendingLight,
                                  () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(25)), // ScreenUtilHelper
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.width(15.0), // ScreenUtilHelper
                      ),
                      child: Column(
                        children: [
                          GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 123 / 75,
                            ),
                            itemCount: state.students.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final student = state.students[index];
                              return StudentCard(student: student);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(80)), // ScreenUtilHelper
                  ],
                ),
              );
            }
            return Container();
          },
        ),
        bottomSheet: Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(20.0), // ScreenUtilHelper
            vertical: ScreenUtilHelper.height(20.0), // ScreenUtilHelper
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: ScreenUtilHelper.width(118), // ScreenUtilHelper
                height: ScreenUtilHelper.height(44), // ScreenUtilHelper
                child: OutlinedButton(
                  onPressed: ()=>GoRouter.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.tertiaryDarker),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)), // ScreenUtilHelper
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), // ScreenUtilHelper
                      fontWeight: AppStyles.weight.emphasis,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(width: ScreenUtilHelper.width(50)), // ScreenUtilHelper
              SizedBox(
                width: ScreenUtilHelper.width(118), // ScreenUtilHelper
                height: ScreenUtilHelper.height(44), // ScreenUtilHelper
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tertiaryDarker,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)), // ScreenUtilHelper
                    ),
                  ),
                  child: Text(
                    'Upload',
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), // ScreenUtilHelper
                      fontWeight: AppStyles.weight.emphasis,
                      color: AppColors.white,
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

  Future<void> _selectDate(BuildContext context, DateTime initialDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != initialDate) {
      context.read<UpdateAttendanceBloc>().add(SelectDate(picked));
    }
  }

  String _formatDate(DateTime date) {
    const monthNames = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
    ];
    return "${date.day} ${monthNames[date.month - 1]} ${date.year}";
  }

  Widget _buildActionButton(String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: AppColors.blackHighEmphasis,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(5)), // ScreenUtilHelper
        ),
        elevation: 0,
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtilHelper.height(8), // ScreenUtilHelper
          horizontal: ScreenUtilHelper.width(5), // ScreenUtilHelper
        ),
      ),
      child: SizedBox(
        width: ScreenUtilHelper.width(85), // ScreenUtilHelper
        height: ScreenUtilHelper.height(30), // ScreenUtilHelper
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ScreenUtilHelper.fontSize(AppStyles.size.tiny), // ScreenUtilHelper
              fontWeight: AppStyles.weight.regular,
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
