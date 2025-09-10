import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart'; // added
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/bloc/attendance_details_bloc/attendance_details_bloc.dart';
import 'package:go_router/go_router.dart';
import '../widgets/attendance_card.dart';
import '../widgets/donut_chart.dart';

class AttendanceDetails extends StatelessWidget {
  const AttendanceDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // added

    return BlocProvider(
      create: (context) => AttendanceDetailsBloc()
        ..add(
          LoadAttendanceDetails(
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
                height: ScreenUtilHelper.height(30), // added
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
                  Container(
                    margin: EdgeInsets.only(
                      top: ScreenUtilHelper.height(8), // added
                      right: ScreenUtilHelper.width(8), // added
                    ),
                    padding: EdgeInsets.all(ScreenUtilHelper.radius(1)), // added
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: ScreenUtilHelper.width(15), // added
                      minHeight: ScreenUtilHelper.height(15), // added
                    ),
                    child: Center(
                      child: Text(
                        "3",
                        style: AppStyles.small.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: BlocBuilder<AttendanceDetailsBloc, AttendanceDetailsState>(
          builder: (context, state) {
            if (state is AttendanceDetailsInitial || state is AttendanceDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AttendanceDetailsError) {
              return Center(
                child: Text(
                  state.message,
                  style: AppStyles.bodyEmphasis,
                ),
              );
            } else if (state is AttendanceDetailsLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(12)), // added
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: ScreenUtilHelper.height(8)), // added
                        child: Row(
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
                            SizedBox(width: ScreenUtilHelper.width(8)), // added
                            Text(
                              'Attendance Details',
                              style: AppStyles.bodyEmphasis.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: ScreenUtilHelper.height(10)), // added
                      Container(
                        height: ScreenUtilHelper.height(40), // added
                        decoration: BoxDecoration(
                          color: AppColors.linen,
                          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)), // added
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtilHelper.width(12)), // added
                              child: const Icon(Icons.search, color: AppColors.ash),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                  hintText: 'Search Student...',
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                                ),
                                style: AppStyles.bodySmall,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtilHelper.width(12)), // added
                              child: const Icon(Icons.mic, color: AppColors.ash),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: ScreenUtilHelper.height(20)), // added
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: ScreenUtilHelper.height(44), // added
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtilHelper.width(12)), // added
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primaryContrast),
                                borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)), // added
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: state.selectedClass,
                                  isExpanded: true,
                                  hint: Text(
                                    'Class XA',
                                    style: AppStyles.bodySmallEmphasis.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: AppColors.blackMediumEmphasis,
                                  ),
                                  elevation: 1,
                                  style: AppStyles.bodySmall.copyWith(
                                    color: AppColors.black,
                                  ),
                                  onChanged: (String? newValue) {
                                    context.read<AttendanceDetailsBloc>().add(
                                      SelectClass(newValue!),
                                    );
                                  },
                                  items: <String>['Class XA', 'Class XB', 'Class XC']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: ScreenUtilHelper.width(12)), // added
                          Expanded(
                            child: InkWell(
                              onTap: () => _selectDate(context, state.selectedDate),
                              child: Container(
                                height: ScreenUtilHelper.height(44), // added
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtilHelper.width(12)), // added
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.primaryContrast),
                                  borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)), // added
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _formatDate(state.selectedDate),
                                      style: AppStyles.bodySmall.copyWith(
                                        color: AppColors.black,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.calendar_today_outlined,
                                      color: AppColors.blackMediumEmphasis,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtilHelper.height(25)), // added
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: ScreenUtilHelper.width(361), // added
                            height: ScreenUtilHelper.height(16), // added
                            child: Image.asset(
                              "assets/images/title.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: ScreenUtilHelper.height(10)), // added
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.students.length,
                            itemBuilder: (context, index) {
                              final student = state.students[index];
                              return AttendanceCard(student: student);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenUtilHelper.height(8),
                                horizontal: ScreenUtilHelper.width(16)), // added
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: ScreenUtilHelper.width(8)), // added
                            child: Text(
                              "Attendance Graph",
                              style: AppStyles.smallEmphasis.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: ScreenUtilHelper.height(10)), // added
                          Column(
                            children: [
                              Center(
                                child: Container(
                                  width: ScreenUtilHelper.width(343), // added
                                  height: ScreenUtilHelper.height(287), // added
                                  color: AppColors.white,
                                  child: Column(
                                    children: [
                                      SizedBox(height: ScreenUtilHelper.height(20)), // added
                                      Text(
                                        "Attendance - ${_formatDate(state.selectedDate)}",
                                        style: AppStyles.bodyEmphasis.copyWith(
                                          color: AppColors.black,
                                        ),
                                      ),
                                      SizedBox(height: ScreenUtilHelper.height(35)), // added
                                      const DonutChart(
                                        percentage: 0.7,
                                        centerText: '70%',
                                        label: 'Present',
                                      ),
                                      SizedBox(height: ScreenUtilHelper.height(25)), // added
                                      Container(
                                        width: ScreenUtilHelper.width(343), // added
                                        height: ScreenUtilHelper.height(40), // added
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage("assets/images/PrimaryLegend.png"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtilHelper.height(100)), // added
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
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
      context.read<AttendanceDetailsBloc>().add(SelectDate(picked));
    }
  }

  String _formatDate(DateTime date) {
    const monthNames = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
    ];
    return "${date.day} ${monthNames[date.month - 1]} ${date.year}";
  }
}
