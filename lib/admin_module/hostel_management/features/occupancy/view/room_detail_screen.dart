import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../../../routes/app_routes.dart';
import '../bloc/occupancy_bloc.dart';

class RoomOccupancyDetailScreen extends StatefulWidget {
  final String roomId; // Passed from router
  const RoomOccupancyDetailScreen({super.key, required this.roomId});

  @override
  State<RoomOccupancyDetailScreen> createState() =>
      _RoomOccupancyDetailScreenState();
}

class _RoomOccupancyDetailScreenState extends State<RoomOccupancyDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // The problematic line has been removed from here.
    _tabController = TabController(length: 3, vsync: this);
    context.read<OccupancyBloc>().add(LoadRoomDetails(widget.roomId));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color _getBedColor(BedStatus status, bool isSelected) {
    switch (status) {
      case BedStatus.vacant:
        return AppColors.cloud;
      case BedStatus.occupied:
        return AppColors.success;
      case BedStatus.pending:
        return AppColors.pendingAlt;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // This call is correct and sufficient.
    ScreenUtilHelper.init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.primaryColor),
          onPressed: () => context.pop(),
        ),
        title: Image.asset(
          'assets/images/edudibon_logo.png',
          width: ScreenUtilHelper.scaleWidth(100),
          height: ScreenUtilHelper.scaleHeight(50),
        ),
      ),
      body: BlocConsumer<OccupancyBloc, OccupancyState>(
        listener: (context, state) {
          if (state is InquirySubmissionSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is OccupancyLoading && state is! RoomDetailLoadSuccess) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is RoomDetailLoadSuccess) {
            final room = state.room;
            final occupancyType = room.totalBeds == 1
                ? "Single"
                : room.totalBeds == 2
                ? "Double"
                : "Triple";

            return Padding(
              padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$occupancyType Occupancy',
                      style: theme.textTheme.bodyMedium),
                  Text('Room ${room.roomNumber}',
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
                  Text('Select bed', style: theme.textTheme.titleMedium),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
                  Row(
                    children: List.generate(room.beds.length, (index) {
                      final bedStatus = room.beds[index];
                      bool isSelectedForInquiry =
                          (bedStatus == BedStatus.pending ||
                              bedStatus == BedStatus.vacant) &&
                              state.selectedBed == bedStatus;

                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: ScreenUtilHelper.scaleWidth(50),
                          height: ScreenUtilHelper.scaleHeight(30),
                          margin: EdgeInsets.only(
                              right: ScreenUtilHelper.scaleWidth(8)),
                          decoration: BoxDecoration(
                            color: _getBedColor(bedStatus, isSelectedForInquiry),
                            borderRadius: BorderRadius.circular(
                                ScreenUtilHelper.scaleAll(4)),
                            border: isSelectedForInquiry
                                ? Border.all(color: theme.primaryColor, width: 2)
                                : null,
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
                  TabBar(
                    controller: _tabController,
                    labelColor: theme.primaryColor,
                    unselectedLabelColor: AppColors.ash,
                    indicatorColor: theme.primaryColor,
                    tabs: const [
                      Tab(text: 'Inquiry'),
                      Tab(text: 'Booked'),
                      Tab(text: 'Canceled'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildInquiryTab(context, state),
                        _buildBookedTab(context, state),
                        _buildCanceledTab(context),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          if (state is OccupancyError) {
            return Center(
                child: Text('Error loading room details: ${state.message}'));
          }
          return const Center(child: Text('Loading room details...'));
        },
      ),
    );
  }

  Widget _buildInquiryTab(BuildContext context, RoomDetailLoadSuccess state) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: ScreenUtilHelper.scaleHeight(16.0)),
      child: Column(
        children: [
          OutlinedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Create an Inquiry'),
            onPressed: () {
              context.push(
                  AppRoutes.hostelInquiryForm.replaceFirst(':roomId', state.room.id));
            },
            style: OutlinedButton.styleFrom(
              minimumSize: Size(double.infinity, ScreenUtilHelper.scaleHeight(48)),
              side: BorderSide(color: theme.primaryColor),
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(ScreenUtilHelper.scaleAll(8))),
            ),
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
          if (state.inquiries.isEmpty)
            const Text('No inquiries for this room yet.')
          else
            ...state.inquiries
                .map((student) => _StudentCard(
              student: student,
              statusText: 'Inquiry',
              statusColor: AppColors.pending,
              onAction: () {
                context.push(AppRoutes.hostelBookingConfirm
                    .replaceFirst(':roomId', state.room.id));
              },
              actionText: "View / Confirm",
            ))
                .toList(),
        ],
      ),
    );
  }

  Widget _buildBookedTab(BuildContext context, RoomDetailLoadSuccess state) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: ScreenUtilHelper.scaleHeight(16.0)),
      child: Column(
        children: [
          if (state.bookedStudents.isEmpty)
            const Text('No students currently booked in this room.')
          else
            ...state.bookedStudents
                .map((student) => _StudentCard(
              student: student,
              statusText: 'Booked',
              statusColor: AppColors.success,
              onAction: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                    Text("View Receipt Tapped (Not Implemented)")));
              },
              actionText: 'Receipt',
            ))
                .toList(),
        ],
      ),
    );
  }

  Widget _buildCanceledTab(BuildContext context) {
    return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('No canceled records for this room.'),
        ));
  }
}

class _StudentCard extends StatelessWidget {
  final HostelStudent student;
  final String statusText;
  final Color statusColor;
  final VoidCallback onAction;
  final String actionText;

  const _StudentCard({
    required this.student,
    required this.statusText,
    required this.statusColor,
    required this.onAction,
    required this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: AppColors.white,
      margin: EdgeInsets.symmetric(vertical: ScreenUtilHelper.scaleHeight(8.0)),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16.0)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${student.id.substring(0, 3)}-${student.id.substring(3)}',
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: theme.primaryColor),
                      ),
                      Text(
                        statusText,
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: statusColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(student.name,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Text(student.email, style: theme.textTheme.bodyMedium),
                  Text(student.phone, style: theme.textTheme.bodyMedium),
                  Text(student.department, style: theme.textTheme.bodyMedium),
                  Text(student.year, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
            SizedBox(width: ScreenUtilHelper.scaleWidth(16)),
            Column(
              children: [
                CircleAvatar(
                  radius: ScreenUtilHelper.scaleAll(35),
                  backgroundImage: student.photoUrl != null
                      ? NetworkImage(student.photoUrl!)
                      : null,
                  child: student.photoUrl == null
                      ? const Icon(Icons.person, size: 35)
                      : null,
                ),
                SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
                if (actionText.isNotEmpty)
                  OutlinedButton(
                    onPressed: onAction,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.scaleWidth(10),
                        vertical: ScreenUtilHelper.scaleHeight(5),
                      ),
                      side: BorderSide(color: theme.primaryColor.withOpacity(0.5)),
                    ),
                    child: Text(actionText,
                        style: AppStyles.small),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}