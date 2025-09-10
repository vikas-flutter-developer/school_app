// lib/data/dashboard_data.dart


import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';

class DashboardItem {
  final IconData icon;
  final String title;
  final String? routeName;

  DashboardItem({required this.icon, required this.title, this.routeName});
}

final List<Map<String, dynamic>> dashboardSections = [
  {
    'title': 'Class Room',
    'items': [
      DashboardItem(icon: Icons.person_outline, title: 'Student\nAttendance', routeName: AppRoutes.studentAttendance),
      DashboardItem(icon: Icons.bar_chart_outlined, title: 'Marks &\nProgress Card', routeName: AppRoutes.marksNProgressCard),
      DashboardItem(icon: Icons.school_outlined, title: 'Student\nAcademics', routeName: AppRoutes.studentAcademics),
      DashboardItem(icon: Icons.assignment_outlined, title: 'Student Exam', routeName: AppRoutes.studentExam),
    ],
  },
  {
    'title': 'Administration',
    'items': [
      DashboardItem(icon: Icons.list_alt_outlined, title: 'Master Data', routeName: AppRoutes.masterData),
      DashboardItem(icon: Icons.account_balance_wallet_outlined, title: 'Finance report', routeName: AppRoutes.financeReport),
      DashboardItem(icon: Icons.business_outlined, title: 'Facility\nManagement', routeName: AppRoutes.inventoryManagement),
      DashboardItem(icon: Icons.hotel_outlined, title: 'Hostel\nManagement', routeName: AppRoutes.hostelManagement),
      DashboardItem(icon: Icons.people_outline, title: 'Visitor\nManagement', routeName: AppRoutes.visitorManagement),
      DashboardItem(icon: Icons.local_library_outlined, title: 'Library\nManagement', routeName: AppRoutes.libraryManagement),
      DashboardItem(icon: Icons.schedule_outlined, title: 'Time Table', routeName: AppRoutes.adminTimeTable),
      DashboardItem(icon: Icons.directions_bus, title: 'Transport Management', routeName: AppRoutes.adminTransportDashboard),
    ],
  },
  {
    'title': 'Staff Management (HRMS)',
    'items': [
      DashboardItem(icon: Icons.people_outline, title: 'Staff\nManagement', routeName: AppRoutes.staffManagement),
      DashboardItem(icon: Icons.exit_to_app_outlined, title: 'Leave\nManagement', routeName: AppRoutes.leaveManagement),
      DashboardItem(icon: Icons.payment_outlined, title: 'Payroll', routeName: AppRoutes.payroll),
    ]
  },
{
    'title': 'Communication',
    'items': [
      DashboardItem(icon: Icons.message_outlined, title: 'SMS', routeName: AppRoutes.sms),
      DashboardItem(icon: Icons.mail_outline, title: 'Mail', routeName: AppRoutes.mail),
      DashboardItem(icon: Icons.notifications_outlined, title: 'Notice', routeName: AppRoutes.notice),
      DashboardItem(icon: Icons.help_outline, title: 'Support/Help', routeName: AppRoutes.support),
    ]
  },
];