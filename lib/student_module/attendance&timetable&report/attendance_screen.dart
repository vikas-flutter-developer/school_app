// import 'package:edudibon_flutter_bloc/api/api_client.dart';
// import 'package:edudibon_flutter_bloc/data/attendance_repo.dart';
// import '../../../core/utils/app_decorations.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
//
// import '../../core/utils/app_colors.dart';
// import '../../core/utils/app_styles.dart';
// import '../../core/utils/screen_util_helper.dart'; // ✅ Import the helper
// import 'attendance_calender.dart';
// import 'attendance_piechart.dart';
// import 'bloc/attendance_bloc.dart';
// import 'bloc/attendance_event.dart';
// import 'bloc/attendance_state.dart';
// import 'model/attendance_model.dart';
//
// class AttendanceScreen extends StatefulWidget {
//   const AttendanceScreen({super.key});
//
//   @override
//   _AttendanceScreenState createState() => _AttendanceScreenState();
// }
//
// class _AttendanceScreenState extends State<AttendanceScreen> {
//   late AttendanceBloc _attendanceBloc;
//   DateTime _selectedMonth = DateTime(2025, 3);
//
//   @override
//   void initState() {
//     super.initState();
//     _attendanceBloc = AttendanceBloc(
//       attendanceRepository: AttendanceRepository(apiClient: ApiClient()),
//     );
//     _fetchAttendance();
//   }
//
//   void _fetchAttendance() {
//     final fromDate = DateTime(_selectedMonth.year, _selectedMonth.month, 1);
//     final toDate = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0);
//     _attendanceBloc.add(
//       FetchAttendance(
//         fromDate: DateFormat('yyyy-MM-dd').format(fromDate),
//         toDate: DateFormat('yyyy-MM-dd').format(toDate),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Attendance'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications),
//             onPressed: () {
//               // Handle notifications
//             },
//           ),
//         ],
//       ),
//       body: BlocProvider(
//         create: (context) => _attendanceBloc,
//         child: BlocBuilder<AttendanceBloc, AttendanceState>(
//           builder: (context, state) {
//             if (state is AttendanceLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is AttendanceLoaded) {
//               return _buildAttendanceContent(context, state);
//             } else if (state is AttendanceError) {
//               return Center(child: Text('Error: ${state.message}'));
//             } else {
//               return const Center(child: Text('Initial state'));
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAttendanceContent(BuildContext context, AttendanceLoaded state) {
//     List<CalendarEvent> filteredEvents = state.calendarEvents.where((event) {
//       DateTime eventDate = DateTime.parse(event.cdate);
//       return eventDate.year == _selectedMonth.year && eventDate.month == _selectedMonth.month;
//     }).toList();
//
//     DateTime? firstEventDate;
//     if (filteredEvents.isNotEmpty) {
//       firstEventDate = DateTime.parse(filteredEvents.first.cdate);
//     }
//
//     // ✅ Responsive dimensions using ScreenUtilHelper
//     double headingFontSize = ScreenUtilHelper.fontSize(21);
//     double boxTextSize = ScreenUtilHelper.fontSize(16);
//     double boxHeight = ScreenUtilHelper.height(100);
//
//     return SingleChildScrollView(
//       child: Padding(
//         padding: AppDecorations.smallPadding,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Attendance boxes section
//             Wrap(
//               spacing: ScreenUtilHelper.width(10),
//               runSpacing: ScreenUtilHelper.height(10),
//               alignment: WrapAlignment.center,
//               children: [
//                 _buildAttendanceBox('Present', AppColors.attendancePresent, boxTextSize, boxHeight),
//                 _buildAttendanceBox('Absent', AppColors.attendanceAbsent, boxTextSize, boxHeight),
//                 _buildAttendanceBox('Half Day', AppColors.attendanceHalfDay, boxTextSize, boxHeight),
//                 _buildAttendanceBox('Holiday', AppColors.attendanceHoliday, boxTextSize, boxHeight),
//                 _buildAttendanceBox('Late Arrival', AppColors.attendanceLateArrival, boxTextSize, boxHeight),
//                 _buildAttendanceBox('Outdoor', AppColors.attendanceOutdoor, boxTextSize, boxHeight),
//               ],
//             ),
//             SizedBox(height: ScreenUtilHelper.height(24)),
//
//             // Month navigation
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.chevron_left),
//                   onPressed: () {
//                     setState(() {
//                       _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
//                       _fetchAttendance();
//                     });
//                   },
//                 ),
//                 Text(
//                   firstEventDate != null
//                       ? DateFormat('MMMM yyyy').format(firstEventDate)
//                       : DateFormat('MMMM yyyy').format(_selectedMonth),
//                   style: AppStyles.heading.copyWith(fontSize: headingFontSize),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.chevron_right),
//                   onPressed: () {
//                     setState(() {
//                       _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
//                       _fetchAttendance();
//                     });
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: ScreenUtilHelper.height(16)),
//
//             // Attendance calendar
//             AttendanceCalendar(
//               calendarData: filteredEvents,
//               selectedMonth: _selectedMonth,
//             ),
//             SizedBox(height: ScreenUtilHelper.height(24)),
//
//             // Attendance and leaves summary
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Text('Overall Attendance', style: AppStyles.bold),
//                       SizedBox(height: ScreenUtilHelper.height(12)),
//                       AttendancePieChart(presentPercentage: 81),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Text('Total leaves taken', style: AppStyles.bold),
//                       SizedBox(height: ScreenUtilHelper.height(80)), // ~0.1 of 812
//                       Text(
//                         '4 Days',
//                         style: AppStyles.headingLarge.copyWith(color: AppColors.black),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAttendanceBox(String label, Color color, double textSize, double boxHeight) {
//     return Container(
//       width: ScreenUtilHelper.width(105), // ~375 * 0.28
//       height: boxHeight,
//       padding: EdgeInsets.symmetric(
//         horizontal: ScreenUtilHelper.width(16),
//         vertical: ScreenUtilHelper.height(12),
//       ),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: AppDecorations.circleRadius,
//       ),
//       child: Center(
//         child: Text(
//           label,
//           textAlign: TextAlign.center,
//           style: AppStyles.smallEmphasis.copyWith(
//             color: AppColors.black,
//             fontSize: textSize,
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:edudibon_flutter_bloc/api/api_client.dart';
// import 'package:edudibon_flutter_bloc/data/attendance_repo.dart';
// import '../../../core/utils/app_decorations.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
//
// import '../../core/utils/app_colors.dart';
// import '../../core/utils/app_styles.dart';
// import '../../core/utils/screen_util_helper.dart'; // ✅ Import the helper
// import 'attendance_calender.dart';
// import 'attendance_piechart.dart';
// import 'bloc/attendance_bloc.dart';
// import 'bloc/attendance_event.dart';
// import 'bloc/attendance_state.dart';
// import 'model/attendance_model.dart';
//
// class AttendanceScreen extends StatefulWidget {
//   const AttendanceScreen({super.key});
//
//   @override
//   _AttendanceScreenState createState() => _AttendanceScreenState();
// }
//
// class _AttendanceScreenState extends State<AttendanceScreen> {
//   late AttendanceBloc _attendanceBloc;
//   DateTime _selectedMonth = DateTime(2025, 3);
//
//   @override
//   void initState() {
//     super.initState();
//     _attendanceBloc = AttendanceBloc(
//       attendanceRepository: AttendanceRepository(apiClient: ApiClient()),
//       useStaticData: true, // <--- Enable static data here
//     );
//     _fetchAttendance();
//   }
//
//   void _fetchAttendance() {
//     final fromDate = DateTime(_selectedMonth.year, _selectedMonth.month, 1);
//     final toDate = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0);
//     _attendanceBloc.add(
//       FetchAttendance(
//         fromDate: DateFormat('yyyy-MM-dd').format(fromDate),
//         toDate: DateFormat('yyyy-MM-dd').format(toDate),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Attendance'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications),
//             onPressed: () {
//               // Handle notifications here if needed
//             },
//           ),
//         ],
//       ),
//       body: BlocProvider.value(
//         value: _attendanceBloc,
//         child: BlocBuilder<AttendanceBloc, AttendanceState>(
//           builder: (context, state) {
//             if (state is AttendanceLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is AttendanceLoaded) {
//               return _buildAttendanceContent(context, state);
//             } else if (state is AttendanceError) {
//               return Center(child: Text('Error: ${state.message}'));
//             } else {
//               return const Center(child: Text('Initial state'));
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAttendanceContent(BuildContext context, AttendanceLoaded state) {
//     List<CalendarEvent> filteredEvents = state.calendarEvents.where((event) {
//       DateTime eventDate = DateTime.parse(event.cdate);
//       return eventDate.year == _selectedMonth.year && eventDate.month == _selectedMonth.month;
//     }).toList();
//
//     DateTime? firstEventDate;
//     if (filteredEvents.isNotEmpty) {
//       firstEventDate = DateTime.parse(filteredEvents.first.cdate);
//     }
//
//     double headingFontSize = ScreenUtilHelper.fontSize(21);
//     double boxTextSize = ScreenUtilHelper.fontSize(16);
//     double boxHeight = ScreenUtilHelper.height(100);
//
//     return SingleChildScrollView(
//       child: Padding(
//         padding: AppDecorations.smallPadding,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Wrap(
//               spacing: ScreenUtilHelper.width(10),
//               runSpacing: ScreenUtilHelper.height(10),
//               alignment: WrapAlignment.center,
//               children: [
//                 _buildAttendanceBox('Present', AppColors.attendancePresent, boxTextSize, boxHeight),
//                 _buildAttendanceBox('Absent', AppColors.attendanceAbsent, boxTextSize, boxHeight),
//                 _buildAttendanceBox('Half Day', AppColors.attendanceHalfDay, boxTextSize, boxHeight),
//                 _buildAttendanceBox('Holiday', AppColors.attendanceHoliday, boxTextSize, boxHeight),
//                 _buildAttendanceBox('Late Arrival', AppColors.attendanceLateArrival, boxTextSize, boxHeight),
//                 _buildAttendanceBox('Outdoor', AppColors.attendanceOutdoor, boxTextSize, boxHeight),
//               ],
//             ),
//             SizedBox(height: ScreenUtilHelper.height(24)),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.chevron_left),
//                   onPressed: () {
//                     setState(() {
//                       _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
//                       _fetchAttendance();
//                     });
//                   },
//                 ),
//                 Text(
//                   firstEventDate != null
//                       ? DateFormat('MMMM yyyy').format(firstEventDate)
//                       : DateFormat('MMMM yyyy').format(_selectedMonth),
//                   style: AppStyles.heading.copyWith(fontSize: headingFontSize),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.chevron_right),
//                   onPressed: () {
//                     setState(() {
//                       _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
//                       _fetchAttendance();
//                     });
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: ScreenUtilHelper.height(16)),
//
//             AttendanceCalendar(
//               calendarData: filteredEvents,
//               selectedMonth: _selectedMonth,
//             ),
//             SizedBox(height: ScreenUtilHelper.height(24)),
//
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Text('Overall Attendance', style: AppStyles.bold),
//                       SizedBox(height: ScreenUtilHelper.height(12)),
//                       AttendancePieChart(presentPercentage: 81),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Text('Total leaves taken', style: AppStyles.bold),
//                       SizedBox(height: ScreenUtilHelper.height(80)),
//                       Text(
//                         '4 Days',
//                         style: AppStyles.headingLarge.copyWith(color: AppColors.black),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAttendanceBox(String label, Color color, double textSize, double boxHeight) {
//     return Container(
//       width: ScreenUtilHelper.width(105),
//       height: boxHeight,
//       padding: EdgeInsets.symmetric(
//         horizontal: ScreenUtilHelper.width(16),
//         vertical: ScreenUtilHelper.height(12),
//       ),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: AppDecorations.circleRadius,
//       ),
//       child: Center(
//         child: Text(
//           label,
//           textAlign: TextAlign.center,
//           style: AppStyles.smallEmphasis.copyWith(
//             color: AppColors.black,
//             fontSize: textSize,
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _attendanceBloc.close();
//     super.dispose();
//   }
// }
import 'package:edudibon_flutter_bloc/api/api_client.dart';
import 'package:edudibon_flutter_bloc/data/attendance_repo.dart';
import '../../../core/utils/app_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_styles.dart';
import '../../core/utils/screen_util_helper.dart';
import 'attendance_calender.dart';
import 'attendance_piechart.dart';
import 'bloc/attendance_bloc.dart';
import 'bloc/attendance_event.dart';
import 'bloc/attendance_state.dart';
import 'model/attendance_model.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late AttendanceBloc _attendanceBloc;
  DateTime _selectedMonth = DateTime(2025, 3);

  @override
  void initState() {
    super.initState();
    _attendanceBloc = AttendanceBloc(
      attendanceRepository: AttendanceRepository(apiClient: ApiClient()),
      useStaticData: true,
    );
    _fetchAttendance();
  }

  void _fetchAttendance() {
    final fromDate = DateTime(_selectedMonth.year, _selectedMonth.month, 1);
    final toDate = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0);
    _attendanceBloc.add(
      FetchAttendance(
        fromDate: DateFormat('yyyy-MM-dd').format(fromDate),
        toDate: DateFormat('yyyy-MM-dd').format(toDate),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Attendance'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocProvider.value(
        value: _attendanceBloc,
        child: BlocBuilder<AttendanceBloc, AttendanceState>(
          builder: (context, state) {
            if (state is AttendanceLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AttendanceLoaded) {
              return _buildAttendanceContent(context, state);
            } else if (state is AttendanceError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('Initial state'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildAttendanceContent(BuildContext context, AttendanceLoaded state) {
    List<CalendarEvent> filteredEvents = state.calendarEvents.where((event) {
      DateTime eventDate = DateTime.parse(event.cdate);
      return eventDate.year == _selectedMonth.year && eventDate.month == _selectedMonth.month;
    }).toList();

    DateTime? firstEventDate;
    if (filteredEvents.isNotEmpty) {
      firstEventDate = DateTime.parse(filteredEvents.first.cdate);
    }

    double fontSizeLegend = ScreenUtilHelper.fontSize(14);

    // return SingleChildScrollView(
    //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       // Status pills row
    //       Wrap(
    //         spacing: 12,
    //         runSpacing: 12,
    //         alignment: WrapAlignment.center,
    //         children: [
    //           _buildStatusPill('Present', AppColors.mintGreen),
    //           _buildStatusPill('Absent', AppColors.attendanceAbsent),
    //           _buildStatusPill('Half Day', AppColors.attendanceHalfDay),
    //           _buildStatusPill('Holiday', AppColors.attendanceHoliday),
    //           _buildStatusPill('Late Arrival', AppColors.attendanceLateArrival),
    //           _buildStatusPill('Outdoor', AppColors.attendanceOutdoor),
    //         ],
    //       ),
    //
    //       const SizedBox(height: 20),
    //
    //       // Month navigation
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           IconButton(
    //             icon: const Icon(Icons.chevron_left),
    //             onPressed: () {
    //               setState(() {
    //                 _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
    //                 _fetchAttendance();
    //               });
    //             },
    //           ),
    //           Text(
    //             firstEventDate != null
    //                 ? DateFormat('MMMM yyyy').format(firstEventDate)
    //                 : DateFormat('MMMM yyyy').format(_selectedMonth),
    //             style: AppStyles.heading.copyWith(fontSize: ScreenUtilHelper.fontSize(18)),
    //           ),
    //           IconButton(
    //             icon: const Icon(Icons.chevron_right),
    //             onPressed: () {
    //               setState(() {
    //                 _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
    //                 _fetchAttendance();
    //               });
    //             },
    //           ),
    //         ],
    //       ),
    //
    //       const SizedBox(height: 10),
    //
    //       // Attendance Calendar
    //       AttendanceCalendar(
    //         calendarData: filteredEvents,
    //         selectedMonth: _selectedMonth,
    //       ),
    //
    //       const SizedBox(height: 32),
    //
    //       // Bottom row with Pie Chart and Total Leaves
    //       Row(
    //         children: [
    //           Expanded(
    //             child: Column(
    //               children: [
    //                 Text('Overall Attendance', style: AppStyles.bold),
    //                 const SizedBox(height: 8),
    //                 AttendancePieChart(presentPercentage: 81),
    //                 const SizedBox(height: 4),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     _buildLegendBox(AppColors.attendancePresent),
    //                     const SizedBox(width: 6),
    //                     Text('Present', style: TextStyle(fontSize: fontSizeLegend)),
    //                     const SizedBox(width: 12),
    //                     _buildLegendBox(AppColors.attendanceAbsent),
    //                     const SizedBox(width: 6),
    //                     Text('Absent', style: TextStyle(fontSize: fontSizeLegend)),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Expanded(
    //             child: Column(
    //               children: [
    //                 Text('Total leaves taken', style: AppStyles.bold),
    //                 const SizedBox(height: 16),
    //                 Text(
    //                   '4 Days',
    //                   style: AppStyles.headingLarge.copyWith(color: AppColors.black),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Status pills in two rows (3 per row)
          Column(
            children: [
              // First row of pills
              Wrap(
                spacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _buildStatusPill('Present', AppColors.mintGreen),
                  _buildStatusPill('Absent', AppColors.attendanceAbsent),
                  _buildStatusPill('Half Day', AppColors.attendanceHalfDay),
                ],
              ),
              const SizedBox(height: 12), // Space between the two rows
              // Second row of pills
              Wrap(
                spacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _buildStatusPill('Holiday', AppColors.attendanceHoliday),
                  _buildStatusPill('Late Arrival', AppColors.attendanceLateArrival),
                  _buildStatusPill('Outdoor', AppColors.attendanceOutdoor),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Month navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
                    _fetchAttendance();
                  });
                },
              ),
              Text(
                firstEventDate != null
                    ? DateFormat('MMMM yyyy').format(firstEventDate)
                    : DateFormat('MMMM yyyy').format(_selectedMonth),
                style: AppStyles.heading.copyWith(fontSize: ScreenUtilHelper.fontSize(18)),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
                    _fetchAttendance();
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Attendance Calendar
          AttendanceCalendar(
            calendarData: filteredEvents,
            selectedMonth: _selectedMonth,
          ),

          const SizedBox(height: 32),

          // Bottom row with Pie Chart and Total Leaves
          // Row(
          //   children: [
          //     Expanded(
          //       child: Column(
          //         children: [
          //           Text('Overall Attendance', style: AppStyles.bold),
          //           const SizedBox(height: 8),
          //           AttendancePieChart(presentPercentage: 81),
          //           const SizedBox(height: 4),
          //           // Row(
          //           //   mainAxisAlignment: MainAxisAlignment.center,
          //           //   children: [
          //           //     _buildLegendBox(AppColors.attendancePresent),
          //           //     const SizedBox(width: 6),
          //           //     Text('Present', style: TextStyle(fontSize: fontSizeLegend)),
          //           //     const SizedBox(width: 12),
          //           //     _buildLegendBox(AppColors.attendanceAbsent),
          //           //     const SizedBox(width: 6),
          //           //     Text('Absent', style: TextStyle(fontSize: fontSizeLegend)),
          //           //   ],
          //           // ),
          //         ],
          //       ),
          //     ),
          //     Expanded(
          //       child: Column(
          //         children: [
          //           Text('Total leaves taken', style: AppStyles.bold),
          //           const SizedBox(height: 16),
          //           Text(
          //             '4 Days',
          //             style: AppStyles.headingLarge.copyWith(color: AppColors.black),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          Row(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Overall Attendance', style: AppStyles.bold),
                    const SizedBox(height: 8),
                    AttendancePieChart(presentPercentage: 81),
                    const SizedBox(height: 4),

                  ],
                ),
              ),


              const SizedBox(width: 16),

              // 2. Right Column (Total Leaves)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Total leaves taken', style: AppStyles.bold),
                    const SizedBox(height: 55),
                    Text(
                      '4 Days',
                      style: AppStyles.headingLarge.copyWith(color: AppColors.black),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatusPill(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        label,
        style: TextStyle(color: AppColors.black, fontWeight: AppStyles.weight.emphasis)
      ),
    );
  }

  Widget _buildLegendBox(Color color) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  @override
  void dispose() {
    _attendanceBloc.close();
    super.dispose();
  }
}
