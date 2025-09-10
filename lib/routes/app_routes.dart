import 'package:edudibon_flutter_bloc/admin_module/MasterData/master_data_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/Student_Academic/student_academics_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/Student_Details/student_details_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/Student_exam/student_exam_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/communication_management/mail_management/bloc/mail_bloc.dart';
import 'package:edudibon_flutter_bloc/admin_module/communication_management/mail_management/screens/mail_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/communication_management/message_management/screens/message_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/communication_management/notice_management/bloc/notice/notice_bloc.dart';
import 'package:edudibon_flutter_bloc/admin_module/communication_management/notice_management/screens/create_new_message_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/communication_management/notice_management/screens/edit_message_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/communication_management/notice_management/screens/notice_main_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/communication_management/support_management/screens/help_desk_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/fee_management/fees_management_dashboard_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/fee_management/fees_structure_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/attendance_overview/bloc/attendance_overview/attendance_overview_bloc.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/attendance_overview/bloc/student_profile/student_profile_bloc.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/attendance_overview/models/student_card_model.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/attendance_overview/screens/attendance_overview_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/attendance_overview/screens/profile_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/complains/screens/approve_request_sent_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/complains/screens/complains_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/complains/screens/complaint_form_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/emergency/view/emergency_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/fee_payment/screens/fee_payment_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/home/home_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/issue_item/screens/issue_item_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/occupancy/bloc/occupancy_bloc.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/services/bloc/services_bloc.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/services/view/request_sent_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/services/view/service_request_form_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/staff_management/bloc/staff_form_bloc/staff_form_bloc.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/staff_management/bloc/staff_screen_bloc/staff_screen_bloc.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/staff_management/screens/staff_form_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/staff_management/screens/staff_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/visitor_management/bloc/visitor_bloc.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/visitor_management/view/permission_granted_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/visitor_management/view/visitor_form_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hostel_management/features/visitor_management/view/visitor_list_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hrsm/leave_management/screens/LeaveApplicationsScreen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hrsm/leave_management/screens/leave_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hrsm/payroll/screens/payroll_screen_content.dart';
import 'package:edudibon_flutter_bloc/admin_module/hrsm/staff_management/screens/AttendanceScreen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hrsm/staff_management/screens/Dashboard.dart';
import 'package:edudibon_flutter_bloc/admin_module/hrsm/staff_management/screens/EmployeeScreen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hrsm/staff_management/screens/RecruitmentScreen.dart';
import 'package:edudibon_flutter_bloc/admin_module/hrsm/staff_management/screens/approved_page.dart';
import 'package:edudibon_flutter_bloc/admin_module/hrsm/staff_management/screens/employee_profile_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/inventory_management/bloc/indent_management/indent_management_bloc.dart';
import 'package:edudibon_flutter_bloc/admin_module/inventory_management/bloc/inventory_home/inventory_home_bloc.dart';
import 'package:edudibon_flutter_bloc/admin_module/inventory_management/bloc/po_management/po_management_bloc.dart';
import 'package:edudibon_flutter_bloc/admin_module/inventory_management/data/repo/inventory_repository.dart';
import 'package:edudibon_flutter_bloc/admin_module/inventory_management/data/repo/po_repository.dart';
import 'package:edudibon_flutter_bloc/admin_module/inventory_management/pages/create_po_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/inventory_management/pages/indent_list_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/inventory_management/pages/inventory_home_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/inventory_management/pages/po_management_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/library_management/Fine_Management/fine_management_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/library_management/Notification/notifications_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/library_management/Total_Stock/add_book/presentation/bloc/add_book_bloc.dart';
import 'package:edudibon_flutter_bloc/admin_module/library_management/Total_Stock/add_book/presentation/screens/add_book_flow.dart';
import 'package:edudibon_flutter_bloc/admin_module/library_management/Total_Stock/book_list_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/library_management/book_issueing/screens/book_issue_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/library_management/library_dashboard_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/library_management/library_details_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/marks&progress_cards/screen/marks_progress_card_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/tab_bars/Admin_Dashboard/admin_home.dart';
import 'package:edudibon_flutter_bloc/admin_module/tab_bars/admin_profile/Change_Password/password_success_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/timetable&exam_scheduling/screens/exam_management.dart';
import 'package:edudibon_flutter_bloc/admin_module/timetable&exam_scheduling/screens/timetable_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/timetable&exam_scheduling/screens/updated_timetable_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/transport_management/bus_route_management/presentation/add_route_confirm_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/transport_management/bus_route_management/presentation/add_route_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/transport_management/bus_route_management/presentation/route_management_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/transport_management/transport/transport_dashbord/data/driver_detail_model.dart';
import 'package:edudibon_flutter_bloc/admin_module/transport_management/transport/transport_dashbord/screens/driver_detail_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/transport_management/transport/transport_dashbord/screens/driver_management_screen.dart';
import 'package:edudibon_flutter_bloc/admin_module/transport_management/transport/transport_dashbord/screens/live_bus_screens.dart';
import 'package:edudibon_flutter_bloc/admin_module/transport_management/transport/transport_dashbord/screens/transport_management_screen_dashboard.dart';
import 'package:edudibon_flutter_bloc/admin_module/transport_management/transport/transport_dashbord/screens/trip_detail_screens.dart';
import 'package:edudibon_flutter_bloc/api/api_services.dart';
import 'package:edudibon_flutter_bloc/cubit/calendar_cubit.dart';
import 'package:edudibon_flutter_bloc/customs/bottom_navBar.dart';
import 'package:edudibon_flutter_bloc/presentation/Forgot_password_screen/forgot_password_screen.dart';
import 'package:edudibon_flutter_bloc/presentation/login_using_OTP/bloc/login_with_otp_bloc.dart';
import 'package:edudibon_flutter_bloc/presentation/login_using_OTP/login_with_otp_screen.dart';
import 'package:edudibon_flutter_bloc/presentation/otp_confirmation_screen/otp_confirmation_screen.dart';
import 'package:edudibon_flutter_bloc/presentation/otp_login_screen/otp_login_screen.dart';
import 'package:edudibon_flutter_bloc/presentation/set_new_password/set_new_password.dart';
import 'package:edudibon_flutter_bloc/student_module/Bus_Tracking/bloc/bus_tracking1_bloc.dart';
import 'package:edudibon_flutter_bloc/student_module/Bus_Tracking/bus_tracking_screen.dart';
import 'package:edudibon_flutter_bloc/student_module/Bus_Tracking/live_bus_tracking_screen.dart';
import 'package:edudibon_flutter_bloc/student_module/Study_Material/download_screen.dart';
import 'package:edudibon_flutter_bloc/student_module/Study_Material/model/study_material_model.dart';
import 'package:edudibon_flutter_bloc/student_module/Study_Material/see_more_screen.dart';
import 'package:edudibon_flutter_bloc/student_module/Study_Material/study_material_screen.dart';
import 'package:edudibon_flutter_bloc/student_module/Study_Material/view_more_screen.dart';
import 'package:edudibon_flutter_bloc/student_module/Syllabus&Assignment&homework/assignment_screen.dart';
import 'package:edudibon_flutter_bloc/student_module/Syllabus&Assignment&homework/chemicalBond_screen.dart';
import 'package:edudibon_flutter_bloc/student_module/Syllabus&Assignment&homework/mathematics_screen.dart';
import 'package:edudibon_flutter_bloc/student_module/Syllabus&Assignment&homework/science_screen.dart';
import 'package:edudibon_flutter_bloc/student_module/Syllabus&Assignment&homework/submit_screen.dart';
import 'package:edudibon_flutter_bloc/student_module/Syllabus&Assignment&homework/syllabus_screen.dart';
import 'package:edudibon_flutter_bloc/student_module/academic/bloc/student_academic_bloc.dart';
import 'package:edudibon_flutter_bloc/student_module/academic/screen/student_academic_sceen.dart';
import 'package:edudibon_flutter_bloc/student_module/fees_details/fee_due_screens.dart';
import 'package:edudibon_flutter_bloc/student_module/fees_details/payment_screen.dart';
import 'package:edudibon_flutter_bloc/student_module/fees_details/screens/fees_screen.dart';
import 'package:edudibon_flutter_bloc/student_module/fees_details/transaction_status.dart';
import 'package:edudibon_flutter_bloc/student_module/tab_bars&notifications/calendar_screen.dart';
import 'package:edudibon_flutter_bloc/student_module/tab_bars&notifications/feed_sceen.dart';
import 'package:edudibon_flutter_bloc/student_module/tab_bars&notifications/homepage.dart';
import 'package:edudibon_flutter_bloc/student_module/tab_bars&notifications/student_profile/bloc/student_bloc.dart';
import 'package:edudibon_flutter_bloc/student_module/tab_bars&notifications/student_profile/screens/edit_profile_screen.dart';
import 'package:edudibon_flutter_bloc/student_module/tab_bars&notifications/student_profile/screens/student_profile_info_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/communication/features/communication/screens/communication_management_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/communication/features/email/bloc/email_list/email_list_bloc.dart';
import 'package:edudibon_flutter_bloc/teacher_module/communication/features/email/screens/email_compose_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/communication/features/email/screens/email_list_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/communication/features/helpdesk/screens/create_ticket_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/communication/features/helpdesk/screens/helpdesk_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/communication/features/notices/bloc/notice/notice_bloc.dart';
import 'package:edudibon_flutter_bloc/teacher_module/communication/features/notices/screens/notices_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/communication/features/sms/bloc/sms_list/sms_list_bloc.dart';
import 'package:edudibon_flutter_bloc/teacher_module/communication/features/sms/screens/sms_chat_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/communication/features/sms/screens/sms_list_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/event_and_scheduling/bloc/event_schedule/event_schedule_bloc.dart';
import 'package:edudibon_flutter_bloc/teacher_module/event_and_scheduling/screens/event_schedule_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/fee_payment/view/fees_payment_status_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/leave_management/screens/apply_leave_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/leave_management/screens/new_permission_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/leave_management/screens/permission_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/reports_screens/presentation/screens/reports_insights/reports_insights_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/reports_screens/presentation/screens/student_report/student_report_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/service_screen/features/profile/teacher_edit_profile/screens/edit_profile_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/service_screen/features/profile/teacher_profile/teacher_profile_info_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/service_screen/features/service_request/view/raise_service_request_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/service_screen/features/service_request/view/service_request_list_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/service_screen/features/ticket/view/raise_ticket_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/service_screen/features/ticket/view/ticket_list_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/bloc/syllbus/syllabus_bloc.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/models/syllabus_model.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/screens/assignment_questions.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/screens/assignment_report_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/screens/create_assignment.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/screens/preview_assignment.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/screens/teacher_syllable_unit.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/screens/teacher_syllabus_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/bloc/attendance_bloc/attendance_bloc.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/screens/attendance_details.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/screens/attendance_report.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/screens/attendance_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/screens/exam_wise_performance.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/screens/overall_performance.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/screens/performance_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/screens/subject_wise_performance.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/screens/update_attendance.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/screens/view_attendance.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_dashboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../Screens/splashScreen2.dart';
import '../Screens/splash_screen.dart';
import '../admin_module/MasterData/admission_dashboard_screen.dart';
import '../admin_module/MasterData/student_staff_details_screen.dart';
import '../admin_module/communication_management/message_management/bloc/message_bloc.dart';
import '../admin_module/communication_management/notice_management/model/notice_model.dart';
import '../admin_module/hostel_management/features/attendance_overview/bloc/room_details/room_details_bloc.dart';
import '../admin_module/hostel_management/features/attendance_overview/screens/room_details_screen.dart';
import '../admin_module/hostel_management/features/occupancy/view/booking_confirmation_screen.dart';
import '../admin_module/hostel_management/features/occupancy/view/booking_form_medical_screen.dart';
import '../admin_module/hostel_management/features/occupancy/view/inquiry_form_screen.dart';
import '../admin_module/hostel_management/features/occupancy/view/occupancy_dashboard_screen.dart';
import '../admin_module/hostel_management/features/occupancy/view/room_detail_screen.dart';
import '../admin_module/hostel_management/features/occupancy/view/room_list_screen.dart';
import '../admin_module/hostel_management/features/services/view/service_request_list_screen.dart';
import '../admin_module/hrsm/payroll/screens/payroll_screen.dart';
import '../admin_module/hrsm/staff_management/screens/approve_submit.dart';
import '../admin_module/hrsm/staff_management/screens/profile_created.dart';
import '../admin_module/hrsm/staff_management/screens/staff_form-screen.dart';
import '../admin_module/student_attendance/screen/student_attendence_screen.dart';
import '../admin_module/tab_bars/Admin_Feed/feed_screen.dart';
import '../admin_module/tab_bars/admin_profile/admin_profile_screen.dart';
import '../admin_module/tab_bars/admin_profile/bloc/profile_bloc.dart';
import '../presentation/login_screen/login_screen.dart';
import '../student_module/attendance&timetable&report/attendance_screen.dart';
import '../student_module/attendance&timetable&report/bloc/attendance_bloc.dart';
import '../student_module/attendance&timetable&report/bloc/timetable_bloc.dart';
import '../student_module/attendance&timetable&report/timetable_screen.dart';
import '../student_module/tab_bars&notifications/notification_screen.dart';
import '../teacher_module/communication/features/helpdesk/bloc/helpdesk/helpdesk_bloc.dart';
import '../teacher_module/leave_management/bloc/leave_bloc/leave_bloc.dart';
import '../teacher_module/leave_management/bloc/permission_bloc/permission_bloc.dart';
import '../teacher_module/leave_management/screens/service_request_sent_screen.dart';
import '../teacher_module/reports_screens/presentation/blocs/exam_overview/exam_overview_bloc.dart';
import '../teacher_module/reports_screens/presentation/blocs/reports_insights/reports_insights_bloc.dart';
import '../teacher_module/reports_screens/presentation/blocs/student_report/student_report_bloc.dart';
import '../teacher_module/teacher_assessment/bloc/assignment/assignment_bloc.dart';
import '../teacher_module/teacher_assessment/bloc/study_material/study_material_bloc.dart';
import '../teacher_module/teacher_assessment/screens/assignment_submission_screen.dart';

/// # AppRoutes
/// This class defines all the route names as string constants.
///
/// **Best Practices:**
/// - **Full Paths:** All constants should be the full, absolute path starting with `/`.
///   This prevents errors when navigating with `context.go()` from anywhere in the app.
/// - **Nesting:** Nested paths (e.g., `/hostel/occupancy`) are defined by
///   combining the parent and child path names.
/// - **Parameters:** Routes with dynamic parameters (e.g., `:roomId`) should
///   have the parameter name included in the constant.
class AppRoutes {
  //App Start Up routes
  static const String splash = '/';
  static const String splash2 = '/splash';
  static const String login = '/login';
  static const String otpLogin = '/otp_login';
  static const String otpVerify = '/otp_verification';
  static const String otpConfirmation = '/otp_confirmation';
  static const String forgotPassword = '/forgot_password';
  static const String setNewPassword = '/set_new_password';
  static const String passwordSuccess = '/password_success';
  static const String navBar = '/navigation_bar';
  static const String notifications = '/notifications';

  // All roles main dashboards (as top-level paths for the ShellRoute)
  static const String adminDashboard = '/admin';
  static const String adminFeed = '/admin-feed';
  static const String adminProfile = '/admin-profile';
  static const String teacherDashboard = '/teacher';
  static const String teacherFeed = '/teacher-feed';
  static const String teacherProfile = '/teacher-profile';
  static const String teacherEditProfile =
      '/teacher-profile/edit-teacher-profile';
  static const String studentDashboard = '/student';
  static const String studentFeed = '/student-feed';
  static const String studentProfile = '/student-profile';
  static const String studentEditProfile =
      '/student-profile/edit-student-profile';

  /*
     ------------  ADMIN MODULE  ------------
  all screens routes related to admin module are under
  */

  static const String studentAttendance = '/student_attendance';
  static const String marksNProgressCard = '/marks_and_progress_card';
  static const String studentAcademics = '/student_academics';
  static const String studentAcademicDetails =
      '/student_academics/student-details';
  static const String studentExam = '/student_exam';

  //  ------------  master data  ------------
  static const String masterData = '/master_data';
  static const String studentStaffDetails =
      '/master_data/student_staff_details';
  static const String masterDataDetails = '/master_data/admin_dashboard';

  static const String financeReport = '/finance_report';
  static const String feeDues = '/finance_report/fee-dues';
  static const String feeStructure = '/finance_report/fee-structure';

  static const String facilityManagement = '/facility';
  static const String visitorManagement = '/visitor';

  //  ------------  time-table  ------------
  static const String adminTimeTable = '/admin-time-table';
  static const String adminTimeTableManagement =
      '/admin-time-table/time-table-management';
  static const String examManagement = '/admin-time-table/exam-management';

  //  ------------  Hostel Management Paths  ------------
  static const String hostelManagement = '/hostel';
  static const String hostelOccupancyDashboard = '/hostel/occupancy';
  static const String hostelRoomList = '/hostel/occupancy/rooms';
  static const String hostelAttendanceOverview =
      '/hostel/occupancy/attendance_overview';
  static const String hostelAttendanceRoomDetails =
      '/hostel/occupancy/attendance_overview/attendance-room-details';
  static const String hostelStudentDetails =
      '/hostel/occupancy/attendance_overview/hostel-student-details';
  static const String hostelOccupancyRoomDetail =
      '/hostel/occupancy/rooms/room-details'; // Example with param
  static const String hostelInquiryForm =
      '/hostel/occupancy/rooms/:roomId/inquiry';
  static const String hostelBookingForm =
      '/hostel/occupancy/rooms/:roomId/booking-form';
  static const String hostelBookingConfirm =
      '/hostel/occupancy/rooms/:roomId/booking-confirm';
  static const String hostelSeatConfirmed = '/hostel/occupancy/seat-confirmed';

  static const String hostelVisitorManagement = '/hostel/visitors';
  static const String hostelVisitorForm = '/hostel/visitors/new';
  static const String hostelVisitorPermissionGranted =
      '/hostel/visitors/permission-granted';

  static const String hostelServices = '/hostel/services';
  static const String hostelServiceRequestForm = '/hostel/services/new-request';
  static const String hostelServiceRequestSent =
      '/hostel/services/request-sent';

  static const String hostelEmergency = '/hostel/emergency';
  static const String hostelStaffManagement = '/hostel/staff';
  static const String addHostelStaff = '/hostel/staff/add-new-staff';
  static const String hostelStaffRequestSent =
      '/hostel/staff/add-staff-request-sent';
  static const String hostelFeePayment = '/hostel/fees';
  static const String hostelComplaints = '/hostel/complaints';
  static const String hostelComplaintForm = '/hostel/complaints/complaint-form';
  static const String hostelComplaintSent =
      '/hostel/complaints/hostel-complaint-sent';
  static const String hostelIssueItems = '/hostel/issue-items';

  //  ----- Library Management Paths  -----
  static const String libraryManagement = '/library';
  static const String libraryTodayIssued = '/library/today_issued';
  static const String libraryTodayReceived = '/library/today_received';
  static const String libraryDueBooks = '/library/due_books';
  static const String libraryNotifications = '/library/notifications';
  static const String libraryFineManagement = '/library/fine_management';

  static const String libraryTotalStock = '/library/total_stock';
  static const String libraryAddBook = '/library/total_stock/add_book';

  static const String libraryBookIssuing = '/library/book_issuing';

  //  ----- Library Management Paths  -----
  static const String inventoryManagement = '/inventory-management';
  static const String inventory = '/inventory-management/inventory';
  static const String poManagement = '/inventory-management/po-management';
  static const String addPurchaseOrder =
      '/inventory-management/po-management/add-purchase-order';

  // ---------- TRANSPORT MANAGEMENT ---------------------
  static const String adminTransportDashboard = '/admin-transport-dashboard';
  static const String adminLiveTracking =
      '/admin-transport-dashboard/admin-live-tracking';
  static const String driverManagement =
      '/admin-transport-dashboard/driver-management';
  static const String adminDriverDetails =
      '/admin-transport-dashboard/driver-management/admin-driver-details';
  static const String adminTripDetails =
      '/admin-transport-dashboard/driver-management/admin-driver-details/admin-trip-details';
  static const String routeManagement =
      '/admin-transport-dashboard/route-management';
  static const String addRoute =
      '/admin-transport-dashboard/route-management/add-route';
  static const String addRouteConfirm =
      '/admin-transport-dashboard/route-management/add-route-confirmation';

  // ---------- HRMS ---------------------
  static const String staffManagement = '/staff-management';
  static const String staffAttendance = '/staff-management/staff-attendance';
  static const String employees = '/staff-management/employees';
  static const String employeeProfile =
      '/staff-management/employees/employee-profile';
  static const String employeeProfileApproved =
      '/staff-management/employees/employee-profile/profile-approved';
  static const String employeeProfileCreated =
      '/staff-management/employees/employee-profile/profile-created';
  static const String addStaff = '/staff-management/employees/add-staff';
  static const String recruitment =
      '/staff-management/recruitment'
      '';
  static const String leaveManagement = '/leave-management';
  static const String leaveApplications =
      '/leave-management/leave-applications';
  static const String leaveApproved =
      '/leave-management/leave-applications/leave-approved';
  static const String payroll = '/payroll';
  static const String payrollDetails = '/payroll/payroll-details';

  //  ----- Communication Management Paths  -----
  static const String sms = '/sms';
  static const String mail = '/mail';

  static const String notice = '/notice';
  static const String createNewNotice = '/notice/create-new-notice';
  static const String editNotice = '/notice/edit-notice';

  static const String support = '/support';

  //student module routes
  static const String academics = '/academics';
  static const String attendance = '/attendance';
  static const String busTracking = '/bus-tracking';
  static const String liveRoute = '/bus-tracking/live-route';
  static const String assignmentNHomework = '/assignment-and-homework';
  static const String submitHomeWork =
      '/assignment-and-homework/submit-assignment';
  static const String timetable = '/time-table';

  static const String feeNPayment = '/fee-and-payment-status';
  static const String feeDue = '/fee-and-payment-status/fee-due';
  static const String feeTransactions =
      '/fee-and-payment-status/fee-transactions';
  static const String feePayment = '/fee-and-payment-status/fee-payment';

  static const String studyMaterials = '/study-materials';
  static const String studyMaterialsYears =
      '/study-materials/study-material-years';
  static const String studyMaterialsDetails =
      '/study-materials/study-material-years/study-material-details';
  static const String materialDownload =
      '/study-materials/study-material-years/study-material-details/material-download';

  static const String syllabus = '/syllabus';
  static const String syllabusMath = '/syllabus/mathematics';
  static const String syllabusScience = '/syllabus/science';
  static const String syllabusChemistry = '/syllabus/chemical-bonds';

  static const String calender = '/calender';

  //teacher module routes
  static const String attendancePerformance = '/attendance-and-performance';
  static const String teacherAttendance =
      '/attendance-and-performance/teacher-attendance';
  static const String updateAttendance =
      '/attendance-and-performance/teacher-attendance/update-attendance';
  static const String attendanceDetails =
      '/attendance-and-performance/teacher-attendance/attendance-details';
  static const String attendanceReport =
      '/attendance-and-performance/teacher-attendance/attendance-report';

  static const String teacherPerformance =
      '/attendance-and-performance/teacher-performance';
  static const String overallPerformance =
      '/attendance-and-performance/teacher-performance/overall-performance';
  static const String examWisePerformance =
      '/attendance-and-performance/teacher-performance/exam-wise-performance';
  static const String subjectWisePerformance =
      '/attendance-and-performance/teacher-performance/subject-wise-performance';

  static const String assignmentStudentMaterial =
      '/assignment-and-study-materials';
  static const String assignmentGradeChart =
      '/assignment-and-study-materials/assignment-grade-chart';
  static const String createAssignment =
      '/assignment-and-study-materials/create-assignment';
  static const String addAssignmentQuestions =
      '/assignment-and-study-materials/create-assignment/create-assignment-questions';
  static const String previewAssignment =
      '/assignment-and-study-materials/create-assignment/preview-assignment';
  static const String assignmentSubmission =
      '/assignment-and-study-materials/create-assignment/preview-assignment';

  static const String syllabusUnit =
      '/assignment-and-study-materials/syllabus-unit';

  static const String scheduleEvents = '/today-schedule-and-events';

  static const String teacherCommunication = '/announcement-and-communication';
  static const String teacherSms =
      '/announcement-and-communication/teacher-sms';
  static const String teacherSmsChat =
      '/announcement-and-communication/teacher-sms/sms-chat';
  static const String teacherMail =
      '/announcement-and-communication/teacher-mail';
  static const String teacherMailCompose =
      '/announcement-and-communication/teacher-mail/compose-mail';
  static const String teacherNotices =
      '/announcement-and-communication/teacher-notices';
  static const String teacherSupport =
      '/announcement-and-communication/teacher-support';
  static const String createSupport =
      '/announcement-and-communication/teacher-support/create-support';

  static const String examInsightsReports = '/exam-insights-and-reports';
  static const String studentReport =
      '/exam-insights-and-reports/student-report';
  static const String feePaymentStatus = '/fee-payment-and-status';

  static const String serviceList = '/services-list';
  static const String serviceRequest = '/services-list/new-service';

  static const String ticketsList = '/tickets-list';
  static const String raiseTickets = '/tickets-list/raise-tickets';

  static const String leaveOverview = '/leave-overview';
  static const String applyLeave = '/leave-overview/apply-leave';
  static const String applyPermission = '/leave-overview/apply-permission';
  static const String requestSent = '/leave-overview/requestSent';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      /// # APP START UP FLOW
      /// These are top-level routes for the initial application flow.
      /// They are all defined with full, absolute paths.
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
      GoRoute(path: splash2, builder: (context, state) => SplashScreen2()),
      GoRoute(path: login, builder: (context, state) => LoginScreen()),
      GoRoute(
        path: otpLogin,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => LoginWithOtpBloc(),
            child: LoginWithOtpScreen(),
          );
        },
      ),
      GoRoute(path: otpVerify, builder: (context, state) => OtpLoginScreen()),
      GoRoute(
        path: otpConfirmation,
        builder: (context, state) => OtpConfirmationScreen(),
      ),
      GoRoute(
        path: forgotPassword,
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(
        path: setNewPassword,
        builder: (context, state) => SetNewPassword(),
      ),
      GoRoute(
        path: passwordSuccess,
        builder: (context, state) => PasswordSuccessScreen(),
      ),

      /// # SHELL ROUTES
      /// A ShellRoute is used to provide a persistent UI (like a bottom navigation bar)
      /// for a group of routes. All routes defined within the `routes` list of a
      /// ShellRoute will be displayed within its `builder` widget.
      /*
      /////////////////////////////////////////////////////
      -------------   ADMIN ROUTES STARTS   -------------
      ////////////////////////////////////////////////////
      */
      ShellRoute(
        /// The builder returns the `PersistentNavWrapper` (your bottom navigation bar).
        /// The `child` parameter is the widget for the current route within the shell.
        builder:
            (context, state, child) =>
                PersistentNavWrapper(state: state, role: 0, child: child),
        routes: [
          /// These are the top-level routes within the shell.
          /// Their paths should start with `/` and correspond to your bottom nav items.
          GoRoute(
            path: adminDashboard,
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: adminFeed,
            builder: (context, state) => const FeedScreen(),
          ),
          GoRoute(
            path: adminProfile,
            builder: (context, state) {
              return BlocProvider<ProfileBloc>(
                create: (context) => ProfileBloc(),
                child: const AdminProfileScreen(),
              );
            },
          ),
        ],
      ),

      /// # FULL-SCREEN ROUTES (No Bottom Nav)
      /// These routes are defined outside the ShellRoute. They do not have the
      /// persistent navigation bar and are typically pushed on top of a shell route.
      GoRoute(
        path: notifications,
        builder: (context, state) => NotificationPage(),
      ),

      /// # CLASSROOM ROUTES
      GoRoute(
        path: studentAttendance,
        builder: (context, state) => const StudentAttendanceScreen(),
      ),
      GoRoute(
        path: marksNProgressCard,
        builder: (context, state) => const MarksProgressScreen(),
      ),
      GoRoute(
        path: studentAcademics,
        builder: (context, state) => const StudentAcademicsScreen(),
        routes: [
          GoRoute(
            path: studentAcademicDetails.split('/').last,
            builder: (context, state) {
              final data = state.extra as Map;
              final student = data['student'];
              final selectionDisplay = data['selection'];
              return StudentDetailScreen(
                student: student,
                previousScreenTitle: selectionDisplay,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: studentExam,
        builder: (context, state) => const StudentExamScreen(),
      ),

      /// # ADMINISTRATION ROUTES
      /// ## masterData (Example of a nested route structure)
      /// The parent route has a path (`/master_data`), and its children
      /// (`student_staff_details`) have paths relative to the parent.
      GoRoute(
        path: masterData,
        builder: (context, state) => const MasterDataScreen(),
        routes: [
          /// The path here should NOT have a leading `/`.
          /// The full route for this screen is '/master_data/student_staff_details'.
          GoRoute(
            path: studentStaffDetails.split('/').last,
            builder: (context, state) => const StudentStaffDetailsScreen(),
          ),
          GoRoute(
            path: masterDataDetails.split('/').last,
            builder: (context, state) => const AdmissionDashboardScreen(),
          ),
        ],
      ),

      /// # HOSTEL MANAGEMENT ROUTES
      /// ## Hostel Management (A Complex Nested Example)
      /// The parent route is '/hostel'. All child routes are relative to this path.
      GoRoute(
        path: hostelManagement,
        builder: (context, state) => const HostelManagementHome(),
        routes: [
          /// ### Occupancy (Nested under '/hostel')
          GoRoute(
            path: hostelOccupancyDashboard.split('/').last,
            builder: (context, state) {
              return BlocProvider<OccupancyBloc>(
                create: (context) => OccupancyBloc(),
                child: const OccupancyDashboardScreen(),
              );
            },
            routes: [
              /// ### Rooms List (Nested under '/hostel/occupancy')
              GoRoute(
                path: hostelRoomList.split('/').last,
                builder: (context, state) {
                  return BlocProvider<OccupancyBloc>(
                    create: (context) => OccupancyBloc(),
                    child: const RoomListScreen(),
                  );
                },
                routes: [
                  /// ### Room Detail (Nested under '/hostel/occupancy/rooms')
                  /// This route has a path parameter `:roomId`. It is accessed
                  /// via `state.pathParameters['roomId']` in the builder.
                  GoRoute(
                    path: hostelOccupancyRoomDetail.split('/').last,
                    builder: (context, state) {
                      final roomId = state.extra as String;
                      return BlocProvider<OccupancyBloc>(
                        create: (context) => OccupancyBloc(),
                        child: RoomOccupancyDetailScreen(roomId: roomId),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: hostelInquiryForm.split('/').last,
                        builder: (context, state) {
                          final roomId = state.pathParameters['roomId']!;
                          return BlocProvider<OccupancyBloc>(
                            create: (context) => OccupancyBloc(),
                            child: InquiryFormScreen(roomId: roomId),
                          );
                        },
                      ),
                      GoRoute(
                        path: hostelBookingForm.split('/').last,
                        builder: (context, state) {
                          final roomId = state.pathParameters['roomId']!;
                          return BlocProvider<OccupancyBloc>(
                            create: (context) => OccupancyBloc(),
                            child: BookingFormMedicalScreen(
                              roomId: roomId,
                              studentName: "Mayuri Shah",
                            ),
                          );
                        },
                      ),
                      GoRoute(
                        path: hostelBookingConfirm.split('/').last,
                        builder: (context, state) {
                          final roomId = state.pathParameters['roomId']!;
                          return BlocProvider<OccupancyBloc>(
                            create: (context) => OccupancyBloc(),
                            child: BookingConfirmationScreen(
                              roomId: roomId,
                              studentName: "Mayuri Shah",
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: hostelSeatConfirmed.split('/').last,
                    builder: (context, state) => const SeatConfirmedScreen(),
                  ),
                ],
              ),
              GoRoute(
                path: hostelAttendanceOverview.split('/').last,
                builder: (context, state) {
                  return BlocProvider<AttendanceOverviewBloc>(
                    create: (context) => AttendanceOverviewBloc(),
                    child: AttendanceOverviewScreen(),
                  );
                },
                routes: [
                  GoRoute(
                    path: hostelAttendanceRoomDetails.split('/').last,
                    builder: (context, state) {
                      final number = state.extra as int;
                      return BlocProvider<AttendanceRoomDetailsBloc>(
                        create:
                            (context) =>
                                AttendanceRoomDetailsBloc()..add(
                                  AttendanceLoadRoomDetails(number.toString()),
                                ),
                        child: AttendanceRoomDetailsScreen(
                          roomNumber: number.toString(),
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: hostelStudentDetails.split('/').last,
                    builder: (context, state) {
                      final student = state.extra as StudentCardModel;
                      return BlocProvider<HostelStudentProfileBloc>(
                        create:
                            (context) =>
                                HostelStudentProfileBloc()
                                  ..add(LoadStudentProfile(student.roomSeat)),
                        child: HostelProfileScreen(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          /// ### Visitor Management
          GoRoute(
            path: hostelVisitorManagement.split('/').last,
            builder: (context, state) {
              return BlocProvider<VisitorBloc>(
                create: (context) => VisitorBloc(),
                child: VisitorListScreen(),
              );
            },
            routes: [
              GoRoute(
                path: hostelVisitorForm.split('/').last,
                builder: (context, state) {
                  return BlocProvider<VisitorBloc>(
                    create: (context) => VisitorBloc(),
                    child: VisitorFormScreen(),
                  );
                },
              ),
              GoRoute(
                path: hostelVisitorPermissionGranted.split('/').last,
                builder: (context, state) {
                  return BlocProvider<VisitorBloc>(
                    create: (context) => VisitorBloc(),
                    child: PermissionGrantedScreen(),
                  );
                },
              ),
            ],
          ),

          /// ### Staff Management
          GoRoute(
            path: hostelStaffManagement.split('/').last,
            builder: (context, state) {
              return BlocProvider<StaffScreenBloc>(
                create: (context) => StaffScreenBloc(),
                child: StaffScreen(),
              );
            },
            routes: [
              GoRoute(
                path: addHostelStaff.split('/').last,
                builder: (context, state) {
                  return BlocProvider<StaffFormBloc>(
                    create: (context) => StaffFormBloc()..add(LoadStaffForm()),
                    child: HostelStaffFormScreen(),
                  );
                },
              ),
              GoRoute(
                path: hostelStaffRequestSent,
                builder: (context, state) => ApproveRequestSentScreen(),
              ),
            ],
          ),

          /// ### Other Hostel Management Routes
          GoRoute(
            path: hostelFeePayment.split('/').last,
            builder: (context, state) => FeePaymentscreen(),
          ),
          GoRoute(
            path: hostelComplaints.split('/').last,
            builder: (context, state) => ComplainsScreen(),
            routes: [
              GoRoute(
                path: hostelComplaintForm.split('/').last,
                builder: (context, state) => ComplaintFormScreen(),
              ),
              GoRoute(
                path: hostelComplaintSent.split('/').last,
                builder: (context, state) => ApproveRequestSentScreen(),
              ),
            ],
          ),
          GoRoute(
            path: hostelServices.split('/').last,
            builder: (context, state) {
              return BlocProvider<ServiceRequestsBloc>(
                create: (context) => ServiceRequestsBloc(),
                child: ServiceRequestListsScreen(),
              );
            },
            routes: [
              GoRoute(
                path: hostelServiceRequestForm.split('/').last,
                builder: (context, state) {
                  return BlocProvider<ServiceRequestsBloc>(
                    create: (context) => ServiceRequestsBloc(),
                    child: ServiceRequestFormScreen(),
                  );
                },
              ),
              GoRoute(
                path: hostelServiceRequestSent.split('/').last,
                builder: (context, state) {
                  return BlocProvider<ServiceRequestsBloc>(
                    create: (context) => ServiceRequestsBloc(),
                    child: RequestSentScreen(),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: hostelEmergency.split('/').last,
            builder: (context, state) => EmergencyScreen(),
          ),
          GoRoute(
            path: hostelIssueItems.split('/').last,
            builder: (context, state) => IssueItemScreen(),
          ),
        ],
      ),

      GoRoute(
        path: financeReport,
        builder: (context, state) => FeesManagementDashboardScreen(),
        routes: [
          GoRoute(
            path: feeDues.split('/').last,
            builder: (context, state) => FeesDueScreen(),
          ),
          GoRoute(
            path: feeStructure.split('/').last,
            builder: (context, state) => FeesStructureScreen(),
          ),
        ],
      ),

      GoRoute(
        path: inventoryManagement,
        builder: (context, state) {
          return Provider<InventoryRepository>(
            create: (_) => MockInventoryRepository(),
            child: BlocProvider(
              create:
                  (context) => InventoryHomeBloc(
                    inventoryRepository: context.read<InventoryRepository>(),
                  ),
              child: InventoryHomeScreen(),
            ),
          );
        },
        routes: [
          GoRoute(
            path: inventory.split('/').last,
            builder: (context, state) {
              return Provider<InventoryRepository>(
                create: (_) => MockInventoryRepository(),
                child: BlocProvider(
                  create:
                      (context) => IndentBloc(
                        inventoryRepository:
                            context.read<InventoryRepository>(),
                      ),
                  child: IndentListScreen(),
                ),
              );
            },
          ),
          GoRoute(
            path: poManagement.split('/').last,
            builder: (context, state) {
              return Provider<PoRepository>(
                create: (_) => MockPoRepository(),
                child: BlocProvider(
                  create:
                      (context) => PoManagementBloc(
                        poRepository: context.read<PoRepository>(),
                      ),
                  child: PoManagementScreen(),
                ),
              );
            },
            routes: [
              GoRoute(
                path: addPurchaseOrder.split('/').last,
                builder: (context, state) {
                  return Provider<PoRepository>(
                    create: (_) => MockPoRepository(),
                    child: BlocProvider(
                      create:
                          (context) => PoManagementBloc(
                            poRepository: context.read<PoRepository>(),
                          ),
                      child: CreatePoScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),

      /// # LIBRARY MANAGEMENT ROUTES
      GoRoute(
        path: libraryManagement,
        builder: (context, state) => LibraryDashboardScreen(),
        routes: [
          GoRoute(
            path: libraryTodayIssued.split('/').last,
            builder: (context, state) => TodayIssuedScreen(),
          ),
          GoRoute(
            path: libraryTodayReceived.split('/').last,
            builder: (context, state) => TodayReceivedScreen(),
          ),
          GoRoute(
            path: libraryDueBooks.split('/').last,
            builder: (context, state) => DueBooksScreen(),
          ),
          GoRoute(
            path: libraryNotifications.split('/').last,
            builder: (context, state) => NotificationsScreen(),
          ),
          GoRoute(
            path: libraryFineManagement.split('/').last,
            builder: (context, state) => FineManagementScreen(),
          ),
          GoRoute(
            path: libraryTotalStock.split('/').last,
            builder: (context, state) => BookListScreen(),
            routes: [
              GoRoute(
                path: libraryAddBook.split('/').last,
                builder: (context, state) {
                  return BlocProvider(
                    create: (context) => AddBookBloc(),
                    child: AddBookFlow(),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: libraryBookIssuing.split('/').last,
            builder: (context, state) => BookIssueScreen(),
          ),
        ],
      ),

      /// # TIMETABLE ROUTES
      GoRoute(
        path: adminTimeTable,
        builder: (context, state) => TimetableScreen(),
        routes: [
          GoRoute(
            path: adminTimeTableManagement.split('/').last,
            builder: (context, state) => TimetableManagementScreen(),
          ),
          GoRoute(
            path: examManagement.split('/').last,
            builder: (context, state) => ExamSchedulePage(),
          ),
        ],
      ),

      /// # TRANSPORT MANAGEMENT
      GoRoute(
        path: adminTransportDashboard,
        builder: (context, state) => TransportManagementScreen(),
        routes: [
          GoRoute(
            path: adminLiveTracking.split('/').last,
            builder: (context, state) => LiveTrackingScreen(),
          ),
          GoRoute(
            path: driverManagement.split('/').last,
            builder: (context, state) => DriverManagementScreen(),
            routes: [
              GoRoute(path: adminDriverDetails.split('/').last,
              builder: (context,state){
                Driver driver = state.extra as Driver;
                return DriverDetailScreen(driver: driver);
              },
              routes: [
                GoRoute(path: adminTripDetails.split('/').last,
                builder: (context,state)=>TripDetailsScreen(),),
              ]),
            ]
          ),
          GoRoute(
            path: routeManagement.split('/').last,
            builder: (context, state) => RouteScreen(),
            routes: [
              GoRoute(
                path: addRoute.split('/').last,
                builder: (context,state)=>AddRouteScreen(),
              ),
              GoRoute(
                path: addRouteConfirm.split('/').last,
                builder: (context,state)=>AddRouteConfirmScreen(),
              )
            ]
          ),
        ],
      ),

      // ----------------------     HRSM    ----------------------
      GoRoute(
        path: staffManagement,
        builder: (context, state) => StaffManagementDashboard(),
        routes: [
          GoRoute(
            path: staffAttendance.split('/').last,
            builder: (context, state) => StaffAttendanceScreen(),
          ),
          GoRoute(
            path: employees.split('/').last,
            builder: (context, state) {
              return EmployeeScreen();
            },
            routes: [
              GoRoute(
                path: employeeProfile.split('/').last,
                builder: (context, state) {
                  final employeeIndex = state.extra as int;
                  return EmployeeProfileScreen(index: employeeIndex.toString());
                },
                routes: [
                  GoRoute(
                    path: employeeProfileApproved.split('/').last,
                    builder: (context, state) => const ApproveScreen(),
                  ),

                  GoRoute(
                    path: employeeProfileCreated.split('/').last,
                    builder: (context, state) => const ProfileCompleteScreen(),
                  ),
                ],
              ),
              GoRoute(
                path: addStaff.split('/').last,
                builder: (context, state) {
                  return BlocProvider<StaffFormBloc>(
                    create: (context) => StaffFormBloc(),
                    child: StaffFormScreen(),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: recruitment.split('/').last,
            builder: (context, state) => RecruitmentScreen(),
          ),
        ],
      ),
      GoRoute(
        path: leaveManagement,
        builder: (context, state) => LeaveScreen(),
        routes: [
          GoRoute(
            path: leaveApplications.split('/').last,
            builder: (context, state) {
              return BlocProvider<LeaveBloc>(
                create: (context) => LeaveBloc()..add(LoadLeaves()),
                child: LeaveApplicationsScreen(),
              );
            },
            routes: [
              GoRoute(
                path: leaveApproved.split('/').last,
                builder: (context, state) => ApprovedPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: payroll,
        builder: (context, state) => PayrollScreenContent(),
        routes: [
          GoRoute(
            path: payrollDetails.split('/').last,
            builder: (context, state) => PayrollScreen(),
          ),
        ],
      ),

      //  ----------------------     COMMUNICATION    ----------------------

      //SMS
      GoRoute(
        path: sms,
        builder: (context, state) {
          return BlocProvider<MessageBloc>(
            create: (context) => MessageBloc(),
            child: MessageScreenSchedule(),
          );
        },
      ),

      //Mail
      GoRoute(
        path: mail,
        builder: (context, state) {
          return BlocProvider<MailBloc>(
            create: (context) => MailBloc(),
            child: MailScreen(),
          );
        },
      ),

      //Notice
      GoRoute(
        path: notice,
        builder: (context, state) => NoticesMainScreen(),
        routes: [
          GoRoute(
            path: createNewNotice.split('/').last,
            builder: (context, state) {
              return BlocProvider<NoticeBloc>(
                create: (context) => NoticeBloc(),
                child: CreateNewMesage(),
              );
            },
          ),
          GoRoute(
            path: editNotice.split('/').last,
            builder: (context, state) {
              final notice = state.extra as Notice?;
              return BlocProvider<NoticeBloc>(
                create: (context) => NoticeBloc(),
                child: NoticeScreen(notice: notice!),
              );
            },
          ),
        ],
      ),

      //Support/help
      GoRoute(path: support, builder: (context, state) => HelpDeskScreen()),

      /*
      /////////////////////////////////////////////////////
      -------------   ADMIN ROUTES END HERE   -------------
      /////////////////////////////////////////////////////
      -------------   STUDENT ROUTES STARTS   -------------
      /////////////////////////////////////////////////////
      */
      ShellRoute(
        /// The builder returns the `PersistentNavWrapper` (your bottom navigation bar).
        /// The `child` parameter is the widget for the current route within the shell.
        builder:
            (context, state, child) =>
                PersistentNavWrapper(state: state, role: 1, child: child),
        routes: [
          /// These are the top-level routes within the shell.
          /// Their paths should start with `/` and correspond to your bottom nav items.
          GoRoute(
            path: studentDashboard,
            builder: (context, state) => const StudentHomePage(),
          ),
          GoRoute(
            path: studentFeed,
            builder: (context, state) => const StudentFeedScreen(),
          ),
          GoRoute(
            path: studentProfile,
            builder: (context, state) {
              return BlocProvider<StudentBloc>(
                create: (context) => StudentBloc(),
                child: const StudentProfileInfoScreen(),
              );
            },
            routes: [
              GoRoute(
                path: studentEditProfile.split('/').last,
                builder: (context, state) => StudentEditProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      //Academics
      GoRoute(
        path: academics,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => StudentAcademicBloc(),
            child: StudentacademicScreen(),
          );
        },
      ),
      GoRoute(
        path: attendance,
        builder: (context, state) {
          var attendanceRepository;
          return BlocProvider<AttendanceBloc>(
            create:
                (context) =>
                    AttendanceBloc(attendanceRepository: attendanceRepository),
            child: AttendanceScreen(),
          );
        },
      ),
      GoRoute(
        path: busTracking,
        builder: (context, state) {
          return BlocProvider<BusTracking1Bloc>(
            create: (context) => BusTracking1Bloc(),
            child: BusTrackingScreen(),
          );
        },
        routes: [
          GoRoute(
            path: liveRoute.split('/').last,
            builder: (context, state) {
              final route = state.extra as String;
              return LiveBusTrackingScreen(busNumber: route);
            },
          ),
        ],
      ),
      GoRoute(
        path: assignmentNHomework,
        builder: (context, state) => AssignmentScreen(),
        routes: [
          GoRoute(
            path: submitHomeWork.split('/').last,
            builder: (context, state) => SubmitScreen(),
          ),
        ],
      ),
      GoRoute(
        path: timetable,
        builder: (context, state) {
          return BlocProvider<TimetableBloc>(
            create: (context) => TimetableBloc(),
            child: TimetableScreen1(),
          );
        },
      ),
      GoRoute(
        path: studyMaterials,
        builder: (context, state) => StudyMaterialScreen(),
        routes: [
          GoRoute(
            path: studyMaterialsYears.split('/').last,
            builder: (context, state) {
              final title = state.extra as String?;
              return SeeMoreScreen(
                subject: StudyMaterial(title: title!, details: ""),
              );
            },
            routes: [
              GoRoute(
                path: studyMaterialsDetails.split('/').last,
                builder: (context, state) {
                  final mat = state.extra as StudyMaterial;
                  return ViewMoreScreen(subject: mat);
                },
                routes: [
                  GoRoute(
                    path: materialDownload.split('/').last,
                    builder: (context, state) {
                      final data = state.extra as Map;
                      return DownloadScreen(
                        subjectName: data['subjectTitle'],
                        academicYear: data['materialTitle'],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: syllabus,
        builder: (context, state) => SyllabusSearchScreen(),
        routes: [
          GoRoute(
            path: syllabusMath.split('/').last,
            builder: (context, state) => MathematicsDetails(),
          ),
          GoRoute(
            path: syllabusScience.split('/').last,
            builder: (context, state) => ScienceDetails(),
          ),
          GoRoute(
            path: syllabusChemistry.split('/').last,
            builder: (context, state) => ChemicalBondsDetails(),
          ),
        ],
      ),
      GoRoute(
        path: calender,
        builder: (context, state) {
          return Provider(
            create: (_) => CalendarCubit(CalendarApiService()),
            child: CalendarScreen(),
          );
        },
      ),
      GoRoute(
        path: feeNPayment,
        builder: (context, state) => FeeScreen(),
        routes: [
          GoRoute(
            path: feeDue.split('/').last,
            builder: (context, state) => FeesDueScreen(),
          ),
          GoRoute(
            path: feeTransactions.split('/').last,
            builder: (context, state) => TransactionStatusScreen(),
          ),
          GoRoute(
            path: feePayment,
            builder: (context, state) {
              final item = state.extra as FeeDueItem;
              return PaymentPage(amount: item.totalPendingAmount);
            },
          ),
        ],
      ),

      /*
      /////////////////////////////////////////////////////
      -------------   STUDENT ROUTES END HERE   -------------
      /////////////////////////////////////////////////////
      -------------   TEACHER ROUTES STARTS   -------------
      /////////////////////////////////////////////////////
      */
      ShellRoute(
        /// The builder returns the `PersistentNavWrapper` (your bottom navigation bar).
        /// The `child` parameter is the widget for the current route within the shell.
        builder:
            (context, state, child) =>
                PersistentNavWrapper(state: state, role: 2, child: child),
        routes: [
          /// These are the top-level routes within the shell.
          /// Their paths should start with `/` and correspond to your bottom nav items.
          GoRoute(
            path: teacherDashboard,
            builder: (context, state) => const TeacherDashboard(),
          ),
          GoRoute(
            path: teacherFeed,
            builder: (context, state) => const StudentFeedScreen(),
          ),
          GoRoute(
            path: teacherProfile,
            builder: (context, state) => TeacherProfileInfoScreen(),
            routes: [
              GoRoute(
                path: teacherEditProfile,
                builder: (context, state) => TeacherEditProfileScreen(),
              ),
            ],
          ),

          //teacher communication
          GoRoute(
            path: teacherCommunication,
            builder: (context, state) => CommunicationManagementScreen(),
            routes: [
              GoRoute(
                path: teacherSms.split('/').last,
                builder: (context, state) {
                  return BlocProvider<SmsListBloc>(
                    create: (context) => SmsListBloc(),
                    child: SmsListScreen(),
                  );
                },
                routes: [
                  GoRoute(
                    path: teacherSmsChat.split('/').last,
                    builder: (context, state) {
                      final convo = state.extra as SmsConversation?;
                      return SmsChatScreen(
                        conversationId: convo!.id,
                        contactName: convo.name,
                        avatarInitial: convo.avatarInitial,
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: teacherMail.split('/').last,
                builder: (context, state) {
                  return BlocProvider<EmailListBloc>(
                    create: (context) => EmailListBloc(),
                    child: EmailListScreen(),
                  );
                },
                routes: [
                  GoRoute(
                    path: teacherMailCompose.split('/').last,
                    builder: (context, state) => EmailComposeScreen(),
                  ),
                ],
              ),
              GoRoute(
                path: teacherNotices.split('/').last,
                builder: (context, state) {
                  return BlocProvider<TeacherNoticeBloc>(
                    create: (context) => TeacherNoticeBloc(),
                    child: TeacherNoticeScreen(),
                  );
                },
              ),
              GoRoute(
                path: teacherSupport.split('/').last,
                builder: (context, state) {
                  return BlocProvider<TeacherHelpdeskBloc>(
                    create: (context) => TeacherHelpdeskBloc(),
                    child: TeacherHelpdeskScreen(),
                  );
                },
                routes: [
                  GoRoute(
                    path: createSupport.split('/').last,
                    builder: (context, state) => CreateTicketScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      //attendance and performance
      GoRoute(
        path: attendancePerformance,
        builder: (context, state) {
          return BlocProvider<AttendancesBloc>(
            create:
                (context) => AttendancesBloc()..add(LoadAttendanceOptions()),
            child: AttendancePerformanceScreen(),
          );
        },
        routes: [
          GoRoute(
            path: teacherAttendance.split('/').last,
            builder: (context, state) => ViewAttendanceScreen(),
            routes: [
              GoRoute(
                path: updateAttendance.split('/').last,
                builder: (context, state) => UpdateAttendanceScreen(),
              ),
              GoRoute(
                path: attendanceDetails.split('/').last,
                builder: (context, state) => AttendanceDetails(),
              ),
              GoRoute(
                path: attendanceReport.split('/').last,
                builder: (context, state) => AttendanceReportScreen(),
              ),
            ],
          ),
          GoRoute(
            path: teacherPerformance.split('/').last,
            builder: (context, state) => PerformanceScreen(),
            routes: [
              GoRoute(
                path: overallPerformance.split('/').last,
                builder: (context, state) => OverallPerformancePage(),
              ),
              GoRoute(
                path: examWisePerformance.split('/').last,
                builder: (context, state) => ExamWisePerformance(),
              ),
              GoRoute(
                path: subjectWisePerformance.split('/').last,
                builder: (context, state) => SubjectWisePerformance(),
              ),
            ],
          ),
        ],
      ),

      //assignment and study materials
      GoRoute(
        path: assignmentStudentMaterial,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => SyllabusBloc()),
              BlocProvider(create: (context) => AssignmentBloc()),
              BlocProvider(create: (context) => StudyMaterialsBloc()),
            ],
            child: TeacherSyllabusScreen(),
          );
        },
        routes: [
          GoRoute(
            path: assignmentGradeChart.split('/').last,
            builder: (context, state) => AssignmentGradeChart(),
          ),
          GoRoute(
            path: createAssignment.split('/').last,
            builder: (context, state) => CreateAssignment(),
            routes: [
              GoRoute(
                path: addAssignmentQuestions.split('/').last,
                builder: (context, state) => AssignmentQuestion(),
              ),
              GoRoute(
                path: previewAssignment.split('/').last,
                builder: (context, state) => AssignmentPreviewScreen(),
              ),
              GoRoute(
                path: assignmentSubmission.split('/').last,
                builder: (context, state) {
                  final unit = state.extra as SyllabusItems?;
                  return AssignmentSubmissionScreen(syllabusTitle: unit!.title);
                },
              ),
            ],
          ),
          GoRoute(
            path: syllabusUnit.split('/').last,
            builder: (context, state) {
              final unit = state.extra as SyllabusItems?;
              return TeacherSyllableUnit(syllabusTitle: unit!.title);
            },
          ),
        ],
      ),
      GoRoute(
        path: scheduleEvents,
        builder: (context, state) {
          return BlocProvider<EventScheduleBloc>(
            create: (context) => EventScheduleBloc(),
            child: EventScheduleScreen(),
          );
        },
      ),
      GoRoute(
        path: examInsightsReports,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create:
                    (_) =>
                        ReportsInsightsBloc()..add(
                          const LoadReportsData(
                            classId: 'VIII-A',
                            termId: 'Term-I',
                          ),
                        ),
              ),
              BlocProvider(create: (_) => ExamOverviewBloc()),
              BlocProvider(create: (_) => StudentReportBloc()),
            ],
            child: ReportsInsightsScreen(),
          );
        },
        routes: [
          GoRoute(
            path: studentReport.split('/').last,
            builder: (context, state) {
              return BlocProvider(
                create: (context) => StudentReportBloc(),
                child: StudentReportScreen(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: feePaymentStatus,
        builder: (context, state) => FeesPaymentStatusScreen(),
      ),
      GoRoute(
        path: serviceList,
        builder: (context, state) => ServiceRequestListScreen(),
        routes: [
          GoRoute(
            path: serviceRequest.split('/').last,
            builder: (context, state) => RaiseServiceRequestScreen(),
          ),
        ],
      ),
      GoRoute(
        path: ticketsList,
        builder: (context, state) => TicketListScreen(),
        routes: [
          GoRoute(
            path: raiseTickets.split('/').last,
            builder: (context, state) => RaiseTicketScreen(),
          ),
        ],
      ),

      //leave overview
      GoRoute(
        path: leaveOverview,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => PermissionBloc()),
              BlocProvider(create: (context) => LeaveBloc()),
            ],
            child: PermissionScreen(),
          );
        },
        routes: [
          GoRoute(
            path: applyLeave.split('/').last,
            builder: (context, state) => ApplyLeaveScreen(),
          ),
          GoRoute(
            path: applyPermission.split('/').last,
            builder: (context, state) {
              return BlocProvider<PermissionBloc>(
                create: (context) => PermissionBloc(),
                child: NewPermissionScreen(),
              );
            },
          ),
          GoRoute(
            path: requestSent.split('/').last,
            builder: (context, state) => ServiceRequestSentScreen(),
          ),
        ],
      ),
    ],
  );
}
