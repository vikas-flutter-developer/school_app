import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart'; // <-- Added for responsive sizing
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/attendance_report_bloc/attendance_report_bloc.dart';
import '../widgets/attendance_graph.dart';
import '../widgets/donut_chart.dart';

class AttendanceReportScreen extends StatelessWidget {
  const AttendanceReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // <-- Initialize screen util

    return BlocProvider(
      create: (context) =>
      AttendanceReportBloc()
        ..add(
          LoadAttendanceReport(
            selectedClass: 'Class XA',
            fromDate: DateTime(2025, 1, 6),
            toDate: DateTime(2025, 1, 13),
            tabIndex: 0,
          ),
        ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCustomAppBar(context),
                Padding(
                  padding: EdgeInsets.only(
                    left: ScreenUtilHelper.scaleWidth(16),
                    // <-- Responsive padding
                    right: ScreenUtilHelper.scaleWidth(
                        16), // <-- Responsive padding
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTabBar(context),
                      SizedBox(
                        height: ScreenUtilHelper.scaleHeight(
                          MediaQuery
                              .of(context)
                              .size
                              .height * 0.8, // <-- Responsive height
                        ),
                        child: _buildTabBarView(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: ScreenUtilHelper.scaleWidth(8), // <-- responsive left padding
        right: ScreenUtilHelper.scaleWidth(8), // <-- responsive right padding
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(8)),
                // <-- responsive padding
                child: Image.asset(
                  'assets/images/edudibon.png',
                  height: ScreenUtilHelper.scaleHeight(30),
                  // <-- responsive image height
                  fit: BoxFit.contain,
                ),
              ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications_none,
                      color: AppColors.ash,
                      size: ScreenUtilHelper.scaleText(
                          30), // <-- responsive icon size
                    ),
                    onPressed: () {},
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: ScreenUtilHelper.scaleHeight(8),
                      // <-- responsive margin
                      right: ScreenUtilHelper.scaleWidth(
                          8), // <-- responsive margin
                    ),
                    padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(1)),
                    // <-- responsive padding
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: ScreenUtilHelper.scaleWidth(15),
                      // <-- responsive constraint
                      minHeight: ScreenUtilHelper.scaleHeight(
                          15), // <-- responsive constraint
                    ),
                    child: Center(
                      child: Text(
                        "3",
                        style: TextStyle(
                          fontSize: ScreenUtilHelper.scaleText(
                              AppStyles.size.tiny), // <-- responsive font size
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(5)),
          // <-- responsive height
          Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.black,
                      size: ScreenUtilHelper.scaleText(
                          20), // <-- responsive icon size
                    ),
                    onPressed: () => GoRouter.of(context).pop(),
                  ),
                  Text(
                    'Attendance Report',
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.scaleText(AppStyles.size.body),
                      // <-- responsive font size
                      fontWeight: AppStyles.weight.emphasis,
                    ),
                  ),
                ],
              ),
              BlocBuilder<AttendanceReportBloc, AttendanceReportState>(
                builder: (context, state) {
                  if (state is AttendanceReportLoaded && state.tabIndex == 1) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.scaleWidth(
                            16), // <-- responsive horizontal padding
                      ),
                      child: Container(
                        width: ScreenUtilHelper.scaleWidth(363),
                        // <-- responsive width
                        height: ScreenUtilHelper.scaleHeight(36),
                        // <-- responsive height
                        decoration: BoxDecoration(
                          color: AppColors.linen,
                          borderRadius: BorderRadius.circular(
                            ScreenUtilHelper.scaleWidth(
                                10), // <-- responsive border radius
                          ),
                        ),
                        child: TextField(
                          onChanged: (query) {
                            context.read<AttendanceReportBloc>().add(
                              SearchStudents(query),
                            );
                          },
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.stone,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: ScreenUtilHelper.scaleHeight(
                                  10), // <-- responsive content padding
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
              // <-- responsive spacing
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildTabBar(BuildContext context) {
    return BlocBuilder<AttendanceReportBloc, AttendanceReportState>(
      builder: (context, state) {
        if (state is! AttendanceReportLoaded) {
          return const SizedBox.shrink();
        }
        return TabBar(
          controller: TabController(
            length: 3,
            vsync: Scaffold.of(context),
            initialIndex: state.tabIndex,
          ),
          onTap: (index) {
            context.read<AttendanceReportBloc>().add(ChangeTab(index));
          },
          indicator: BoxDecoration(
            color: AppColors.secondaryAccentLight,
            borderRadius: BorderRadius.circular(
                ScreenUtilHelper.scaleRadius(5)),
          ),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          tabs: <Widget>[
            SizedBox(
              width: ScreenUtilHelper.scaleWidth(70),
              height: ScreenUtilHelper.scaleHeight(29),
              child: const Center(child: Text('Weekly')),
            ),
            SizedBox(
              width: ScreenUtilHelper.scaleWidth(70),
              height: ScreenUtilHelper.scaleHeight(29),
              child: const Center(child: Text('Monthly')),
            ),
            SizedBox(
              width: ScreenUtilHelper.scaleWidth(70),
              height: ScreenUtilHelper.scaleHeight(29),
              child: const Center(child: Text('Date wise')),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTabBarView(BuildContext context) {
    return BlocBuilder<AttendanceReportBloc, AttendanceReportState>(
      builder: (context, state) {
        if (state is AttendanceReportInitial ||
            state is AttendanceReportLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AttendanceReportError) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(fontSize: ScreenUtilHelper.scaleText(14)),
            ),
          );
        } else if (state is AttendanceReportLoaded) {
          final List<double> presentData = [30, 32, 35, 33, 36];
          final List<double> halfDayData = [2, 1, 0, 2, 1];
          final List<double> lateData = [5, 6, 1, 3, 2];
          final List<double> absentData = [3, 1, 2, 1, 1];
          final double totalStudents = 40;
          final List<String> weeklydays = ['6th', '7th', '8th', '9th', '10th'];
          final List<String> montlydays = ['1st', '2nd', '3rd', '4th', '5th'];

          switch (state.tabIndex) {
            case 0: // Weekly
              return _buildWeeklyView(
                context,
                presentData,
                halfDayData,
                lateData,
                absentData,
                totalStudents,
                weeklydays,
              );
            case 1: // Monthly
              return _buildMonthlyView(
                context,
                presentData,
                halfDayData,
                lateData,
                absentData,
                totalStudents,
                montlydays,
              );
            case 2: // Date wise
              return _buildDateWiseView(context);
            default:
              return Container();
          }
        }
        return Container();
      },
    );
  }

  Widget _buildWeeklyView(BuildContext context,
      List<double> presentData,
      List<double> halfDayData,
      List<double> lateData,
      List<double> absentData,
      double totalStudents,
      List<String> days,) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ScreenUtilHelper.scaleHeight(20)), // responsive
          _buildDateRangeSelector(),
          SizedBox(height: ScreenUtilHelper.scaleHeight(20)), // responsive
          _buildClassSelector(),
          SizedBox(height: ScreenUtilHelper.scaleHeight(25)), // responsive
          _buildAttendanceTableSection(),
          SizedBox(height: ScreenUtilHelper.scaleHeight(20)), // responsive
          _buildDownloadShareRow(),
          SizedBox(height: ScreenUtilHelper.scaleHeight(30)), // responsive
          AttendanceGraph(
            presentData: presentData,
            halfDayData: halfDayData,
            lateData: lateData,
            absentData: absentData,
            totalStudents: totalStudents,
            days: days,
            title: 'Weekly Attendance- 6th to 13th Jan 25',
            xAxisTitle: 'Days in week',
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(20)), // responsive
        ],
      ),
    );
  }

  Widget _buildMonthlyView(BuildContext context,
      List<double> presentData,
      List<double> halfDayData,
      List<double> lateData,
      List<double> absentData,
      double totalStudents,
      List<String> days,) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: ScreenUtilHelper.scaleHeight(20)), // responsive
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: ScreenUtilHelper.scaleWidth(124),
                    // responsive
                    height: ScreenUtilHelper.scaleHeight(44),
                    // responsive
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.scaleWidth(12), // responsive
                      vertical: ScreenUtilHelper.scaleHeight(10), // responsive
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryContrast),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Class XA',
                          style: TextStyle(
                            fontSize: ScreenUtilHelper.scaleText(AppStyles.size
                                .bodySmall), // responsive
                            fontWeight: AppStyles.weight.emphasis,
                            color: AppColors.black,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.slate,
                          size: ScreenUtilHelper.scaleText(20), // responsive
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: ScreenUtilHelper.scaleWidth(124),
                    // responsive
                    height: ScreenUtilHelper.scaleHeight(44),
                    // responsive
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.scaleWidth(12), // responsive
                      vertical: ScreenUtilHelper.scaleHeight(10), // responsive
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryContrast),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'July 25',
                          style: TextStyle(
                            fontSize: ScreenUtilHelper.scaleText(14),
                            // responsive
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.slate,
                          size: ScreenUtilHelper.scaleText(20), // responsive
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(50)), // responsive
              Padding(
                padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(40)),
                // responsive
                child: Row(
                  children: [
                    Text(
                      "July 25",
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.scaleText(12), // responsive
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryContrast,
                      ),
                    ),
                    SizedBox(width: ScreenUtilHelper.scaleWidth(60)),
                    // responsive
                    Icon(
                      Icons.picture_as_pdf,
                      size: ScreenUtilHelper.scaleText(18), // responsive
                      color: AppColors.stone,
                    ),
                    SizedBox(width: ScreenUtilHelper.scaleWidth(70)),
                    // responsive
                    Icon(
                      Icons.download,
                      size: ScreenUtilHelper.scaleText(18), // responsive
                      color: AppColors.primaryBright,
                    ),
                    SizedBox(width: ScreenUtilHelper.scaleWidth(70)),
                    // responsive
                    Icon(
                      Icons.share_rounded,
                      size: ScreenUtilHelper.scaleText(18), // responsive
                      color: AppColors.primaryBright,
                    ),
                  ],
                ),
              ),
              Divider(
                height: ScreenUtilHelper.scaleHeight(10),
                // responsive
                thickness: 1,
                color: AppColors.primaryContrast,
                indent: ScreenUtilHelper.scaleWidth(20),
                // responsive
                endIndent: ScreenUtilHelper.scaleWidth(190), // responsive
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(50)), // responsive
              AttendanceGraph(
                presentData: presentData,
                halfDayData: halfDayData,
                lateData: lateData,
                absentData: absentData,
                totalStudents: totalStudents,
                days: days,
                title: 'Monthly Attendance- July 25',
                xAxisTitle: 'No. of week',
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildDateWiseView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(8)), // scaled
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: ScreenUtilHelper.scaleHeight(20)), // scaled
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtilHelper.scaleWidth(25)), // scaled
                  child: Container(
                    width: ScreenUtilHelper.scaleWidth(124),
                    // scaled
                    height: ScreenUtilHelper.scaleHeight(44),
                    // scaled
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.scaleWidth(12), // scaled
                      vertical: ScreenUtilHelper.scaleHeight(10), // scaled
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryContrast),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Class XA',
                          style: TextStyle(
                            fontSize: ScreenUtilHelper.scaleText(14), // scaled
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, color: AppColors.slate),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: ScreenUtilHelper.scaleWidth(50)), // scaled
                Padding(
                  padding: EdgeInsets.only(
                      right: ScreenUtilHelper.scaleWidth(16)), // scaled
                  child: Row(
                    children: [
                      Icon(Icons.picture_as_pdf,
                          size: ScreenUtilHelper.scaleWidth(18), // scaled
                          color: AppColors.stone),
                      SizedBox(width: ScreenUtilHelper.scaleWidth(25)),
                      // scaled
                      Text(
                        "July 25",
                        style: TextStyle(
                          fontSize: ScreenUtilHelper.scaleText(12), // scaled
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryContrast,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              height: 0,
              thickness: 1,
              color: AppColors.primaryContrast,
              indent: ScreenUtilHelper.scaleWidth(170),
              // scaled
              endIndent: ScreenUtilHelper.scaleWidth(50), // scaled
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(30)), // scaled
            Container(
              width: ScreenUtilHelper.scaleWidth(277), // scaled
              height: ScreenUtilHelper.scaleHeight(404), // scaled
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.blackMediumEmphasis),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  Container(
                    width: ScreenUtilHelper.scaleWidth(277), // scaled
                    height: ScreenUtilHelper.scaleHeight(55), // scaled
                    decoration: BoxDecoration(
                      color: AppColors.secondaryAccentLight,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Class  XA              Date 13-01-25',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Table(
                    columnWidths: {
                      0: FixedColumnWidth(ScreenUtilHelper.scaleWidth(45)),
                      // scaled
                      1: FixedColumnWidth(ScreenUtilHelper.scaleWidth(60)),
                      // scaled
                      2: FlexColumnWidth(),
                      3: FixedColumnWidth(ScreenUtilHelper.scaleWidth(100)),
                      // scaled
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(color: AppColors.parchment),
                        children: [
                          SizedBox(
                            width: ScreenUtilHelper.scaleWidth(277), // scaled
                            height: ScreenUtilHelper.scaleHeight(44), // scaled
                            child: Padding(
                              padding: EdgeInsets.all(
                                  ScreenUtilHelper.scaleWidth(6)), // scaled
                              child: Text(
                                'Sr.No.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(
                                ScreenUtilHelper.scaleWidth(6)), // scaled
                            child: Text(
                              'ID',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(
                                ScreenUtilHelper.scaleWidth(6)), // scaled
                            child: Text(
                              'Name',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(
                                ScreenUtilHelper.scaleWidth(6)), // scaled
                            child: Text(
                              'Attendance',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      ...List.generate(7, (index) {
                        return TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtilHelper.scaleWidth(6),
                                // scaled
                                vertical: ScreenUtilHelper.scaleHeight(
                                    10), // scaled
                              ),
                              child: Text('${index + 1}',
                                  maxLines: 1, overflow: TextOverflow.ellipsis),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtilHelper.scaleWidth(6),
                                vertical: ScreenUtilHelper.scaleHeight(10),
                              ),
                              child: Text('01234',
                                  maxLines: 1, overflow: TextOverflow.ellipsis),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtilHelper.scaleWidth(6),
                                vertical: ScreenUtilHelper.scaleHeight(10),
                              ),
                              child: Text('Priya A',
                                  maxLines: 1, overflow: TextOverflow.ellipsis),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtilHelper.scaleWidth(6),
                                vertical: ScreenUtilHelper.scaleHeight(10),
                              ),
                              child: Text('P',
                                  maxLines: 1, overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(10)), // scaled
            Row(
              children: [
                Text(
                  'Download',
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.scaleText(14), // scaled
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.file_download_outlined,
                      color: AppColors.primaryDarker),
                  onPressed: () {},
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                      Icons.share_outlined, color: AppColors.primaryDarker),
                  onPressed: () {},
                ),
              ],
            ),
            Text(
              "Attendance Graph",
              style: TextStyle(
                fontSize: ScreenUtilHelper.scaleText(12), // scaled
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(15)), // scaled
            Center(
              child: Container(
                width: ScreenUtilHelper.scaleWidth(343), // scaled
                height: ScreenUtilHelper.scaleHeight(287), // scaled
                color: AppColors.white,
                child: Column(
                  children: [
                    SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
                    // scaled
                    Text(
                      "Date Wise Attendance -13-01-25",
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.scaleText(16), // scaled
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(35)),
                    // scaled
                    DonutChart(
                      percentage: 0.7,
                      centerText: '70%',
                      label: 'Present',
                    ),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(25)),
                    // scaled
                    Container(
                      width: ScreenUtilHelper.scaleWidth(343), // scaled
                      height: ScreenUtilHelper.scaleHeight(40), // scaled
                      decoration: BoxDecoration(
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
      ),
    );
  }


  Widget _buildDateRangeSelector() {
    return Row(
      children: [
        Expanded(child: _buildDateInput('From', '6-01-25')),
        SizedBox(width: ScreenUtilHelper.scaleWidth(15)), // ScreenUtilHelper
        Expanded(child: _buildDateInput('To', '13-01-25')),
      ],
    );
  }

  Widget _buildDateInput(String label, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtilHelper.scaleHeight(8), // ScreenUtilHelper
              horizontal: ScreenUtilHelper.scaleWidth(10), // ScreenUtilHelper
            ),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.silver!)),
            ),
            child: Row(
              children: [
                Text(label, style: TextStyle(color: AppColors.stone)),
                SizedBox(width: ScreenUtilHelper.scaleWidth(5)),
                // ScreenUtilHelper
                Icon(Icons.calendar_today,
                    size: ScreenUtilHelper.scaleHeight(18), // ScreenUtilHelper
                    color: AppColors.stone),
                SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
                // ScreenUtilHelper
                Text(
                  date,
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.scaleText(16),
                    // ScreenUtilHelper
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClassSelector() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenUtilHelper.scaleWidth(124),
        // ScreenUtilHelper
        height: ScreenUtilHelper.scaleHeight(44),
        // ScreenUtilHelper
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.scaleWidth(12.0), // ScreenUtilHelper
          vertical: ScreenUtilHelper.scaleHeight(10.0), // ScreenUtilHelper
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryContrast),
          borderRadius:
          BorderRadius.circular(
              ScreenUtilHelper.scaleRadius(5.0)), // ScreenUtilHelper
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Class XA',
              style: TextStyle(
                fontSize: ScreenUtilHelper.scaleText(16), // ScreenUtilHelper
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: AppColors.slate),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceTableSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.cloud),
        borderRadius: BorderRadius.circular(
            ScreenUtilHelper.scaleRadius(8)), // ScreenUtilHelper
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtilHelper.scaleHeight(12), // ScreenUtilHelper
              horizontal: ScreenUtilHelper.scaleWidth(16), // ScreenUtilHelper
            ),
            decoration: BoxDecoration(
              color: AppColors.linen,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ScreenUtilHelper.scaleRadius(8)),
                // ScreenUtilHelper
                topRight: Radius.circular(
                    ScreenUtilHelper.scaleRadius(8)), // ScreenUtilHelper
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Weekly Report ',
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.scaleText(12),
                        // ScreenUtilHelper
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
                    // ScreenUtilHelper
                    Text(
                      '6-01-2025 ',
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.scaleText(13),
                        // ScreenUtilHelper
                        color: AppColors.primaryContrast,
                      ),
                    ),
                    SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
                    // ScreenUtilHelper
                    Text(
                      'to',
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.scaleText(12),
                        // ScreenUtilHelper
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
                    // ScreenUtilHelper
                    Text(
                      '13-01-2025 ',
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.scaleText(13),
                        // ScreenUtilHelper
                        color: AppColors.primaryContrast,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtilHelper.scaleHeight(4)),
                // ScreenUtilHelper
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Class XA',
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.scaleText(12),
                      // ScreenUtilHelper
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: ScreenUtilHelper.scaleWidth(386), // ScreenUtilHelper
            height: ScreenUtilHelper.scaleHeight(317), // ScreenUtilHelper
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: ScreenUtilHelper.scaleWidth(10.0),
                headingRowHeight: ScreenUtilHelper.scaleHeight(40.0),
                dataRowMinHeight: ScreenUtilHelper.scaleHeight(35),
                headingTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtilHelper.scaleText(12), // ScreenUtilHelper
                  color: AppColors.blackMediumEmphasis,
                ),
                dataTextStyle: TextStyle(
                  fontSize: ScreenUtilHelper.scaleText(13), // ScreenUtilHelper
                  color: AppColors.blackHighEmphasis,
                ),
                columns: const [
                  DataColumn(label: Text('ID', textAlign: TextAlign.center)),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('6/01', textAlign: TextAlign.center)),
                  DataColumn(label: Text('7/01', textAlign: TextAlign.center)),
                  DataColumn(label: Text('8/01', textAlign: TextAlign.center)),
                  DataColumn(label: Text('9/01', textAlign: TextAlign.center)),
                  DataColumn(label: Text('10/01', textAlign: TextAlign.center)),
                  DataColumn(label: Text('11/01', textAlign: TextAlign.center)),
                  DataColumn(label: Text('12/01', textAlign: TextAlign.center)),
                  DataColumn(label: Text('13/01', textAlign: TextAlign.center)),
                ],
                rows: List.generate(12, (index) {
                  return DataRow(
                    cells: [
                      DataCell(Center(child: Text('0123${index + 1}'))),
                      DataCell(
                        Text(
                          'Student ${[
                            'A', 'B', 'C', 'D', 'E', 'F',
                            'G', 'H', 'I', 'J', 'K', 'L'
                          ][index]}',
                        ),
                      ),
                      DataCell(Center(child: Text(index % 3 == 0 ? 'A' : 'P'))),
                      DataCell(const Center(child: Text('P'))),
                      DataCell(Center(child: Text(index % 5 == 0 ? 'L' : 'P'))),
                      DataCell(const Center(child: Text('P'))),
                      DataCell(Center(child: Text(index % 4 == 0 ? 'H' : 'P'))),
                      DataCell(const Center(child: Text('P'))),
                      DataCell(const Center(child: Text('P'))),
                      DataCell(const Center(child: Text('P'))),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildDownloadShareRow() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.scaleWidth(8.0), //  static access
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Download',
                style: TextStyle(
                  fontSize: ScreenUtilHelper.scaleText(14), //  static access
                  fontWeight: FontWeight.w400,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.file_download_outlined,
                  color: AppColors.primaryDarker,
                  size: ScreenUtilHelper.scaleWidth(24), //  static access
                ),
                onPressed: () {},
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.share_outlined,
                  color: AppColors.primaryDarker,
                  size: ScreenUtilHelper.scaleWidth(24), //  static access
                ),
                onPressed: () {},
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Attendance Graph',
              style: TextStyle(
                fontSize: ScreenUtilHelper.scaleText(14), //  static access
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}