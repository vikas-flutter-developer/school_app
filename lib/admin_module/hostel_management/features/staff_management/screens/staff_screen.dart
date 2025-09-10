import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../bloc/staff_form_bloc/staff_form_bloc.dart';
import '../bloc/staff_screen_bloc/staff_screen_bloc.dart';
import '../widgets/attendance_tab_content.dart';
import '../widgets/payments_tab_content.dart';
import '../widgets/staff_card.dart';
import 'staff_form_screen.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<StaffScreenBloc>().add(LoadInitialStaffData());
      }
    });

    _searchController.addListener(() {
      if (mounted) {
        context.read<StaffScreenBloc>().add(
          SearchStaff(_searchController.text),
        );
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildTabItem(
      BuildContext context,
      String title,
      int index,
      bool isActive,
      ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<StaffScreenBloc>().add(TabChanged(index));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppStyles.size.bodySmall,
                fontWeight: isActive ? AppStyles.weight.heading :AppStyles.weight.regular,
                color: isActive ? AppColors.secondaryDarkest : AppColors.stone,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentTabContent(StaffScreenLoaded state) {
    switch (state.selectedTabIndex) {
      case 0:
        if (state.displayStaffList.isEmpty) {
          return Expanded(
            child: Center(
              child: Text(
                state.searchQuery.isNotEmpty
                    ? "No staff found matching '${state.searchQuery}'."
                    : "No staff data available.",
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(
              top: ScreenUtilHelper.height(8.0),
              bottom: ScreenUtilHelper.height(70.0),
            ),
            itemCount: state.displayStaffList.length,
            itemBuilder: (context, index) {
              return StaffCard(staffMember: state.displayStaffList[index]);
            },
          ),
        );
      case 1:
        return Expanded(
          child: AttendanceTabContent(attendanceList: state.attendanceList),
        );
      case 2:
        return const Expanded(child: PaymentsTabContent());
      default:
        return const Expanded(
          child: Center(child: Text("Unknown tab selected.")),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.blackMediumEmphasis,
            size: ScreenUtilHelper.scaleAll(20),
          ),
          onPressed: ()=>GoRouter.of(context).pop(),
        ),
        title: SizedBox(
          width: ScreenUtilHelper.width(159),
          height: ScreenUtilHelper.height(39),
          child: Image.asset("assets/images/edudibon.png"),
        ),
        centerTitle: false,
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications_none_outlined,
                  color: AppColors.blackMediumEmphasis,
                  size: ScreenUtilHelper.scaleAll(28),
                ),
                onPressed: () {},
              ),
              Positioned(
                right: ScreenUtilHelper.width(8),
                top: ScreenUtilHelper.height(8),
                child: Container(
                  padding: EdgeInsets.all(ScreenUtilHelper.width(2)),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius:
                    BorderRadius.circular(ScreenUtilHelper.radius(8)),
                  ),
                  constraints: BoxConstraints(
                    minWidth: ScreenUtilHelper.width(16),
                    minHeight: ScreenUtilHelper.height(16),
                  ),
                  child: Text(
                    '3',
                    style: AppStyles.badge1.copyWith(fontWeight: AppStyles.weight.heading),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: ScreenUtilHelper.width(8)),
        ],
      ),
      body: BlocBuilder<StaffScreenBloc, StaffScreenState>(
        builder: (context, state) {
          if (state is StaffScreenInitial || state is StaffScreenLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is StaffScreenError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: AppColors.error,
                      size: ScreenUtilHelper.scaleAll(48),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(16)),
                    Text(
                      "Error: ${state.message}",
                      textAlign: TextAlign.center,
                      style:AppStyles.body,
                    ),
                    SizedBox(height: ScreenUtilHelper.height(20)),
                    ElevatedButton(
                      onPressed: () {
                        context.read<StaffScreenBloc>().add(
                          LoadInitialStaffData(),
                        );
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is StaffScreenLoaded) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.width(16.0),
                    vertical: ScreenUtilHelper.height(10.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: SizedBox(
                          height: ScreenUtilHelper.height(40),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search by name, ID, department',
                              hintStyle: AppStyles.bodySmall.copyWith(color: AppColors.silver),
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.parchment,
                                size: ScreenUtilHelper.scaleAll(22),
                              ),
                              suffixIcon: Icon(
                                Icons.mic,
                                color: AppColors.stone,
                                size: ScreenUtilHelper.scaleAll(22),
                              ),
                              filled: true,
                              fillColor: AppColors.transparent,
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtilHelper.radius(12.0)),
                                borderSide:
                                const BorderSide(color: AppColors.ash),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtilHelper.radius(12.0)),
                                borderSide:
                                const BorderSide(color: AppColors.ash),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtilHelper.radius(12.0)),
                                borderSide:
                                const BorderSide(color: AppColors.ash),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: ScreenUtilHelper.width(8)),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: ScreenUtilHelper.height(38),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                ScreenUtilHelper.radius(9)),
                            border: Border.all(
                              color: AppColors.accentLight,
                              width: ScreenUtilHelper.width(1.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RotatedBox(
                                quarterTurns: 1,
                                child: Icon(
                                  Icons.tune,
                                  size: ScreenUtilHelper.scaleAll(20),
                                  color: AppColors.secondaryContrast,
                                ),
                              ),
                              SizedBox(width: ScreenUtilHelper.width(5)),
                              Icon(
                                Icons.sort,
                                size: ScreenUtilHelper.scaleAll(20),
                                color: AppColors.secondaryContrast,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.width(16.0)),
                  child: Container(
                    width: double.infinity,
                    height: ScreenUtilHelper.height(41),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(ScreenUtilHelper.radius(9)),
                      color: AppColors.ivory,
                    ),
                    child: Row(
                      children: <Widget>[
                        _buildTabItem(
                          context,
                          'Details',
                          0,
                          state.selectedTabIndex == 0,
                        ),
                        Container(
                          width: ScreenUtilHelper.width(1),
                          height: ScreenUtilHelper.height(24.0),
                          color: AppColors.blackDisabled,
                        ),
                        _buildTabItem(
                          context,
                          'Attendance',
                          1,
                          state.selectedTabIndex == 1,
                        ),
                        Container(
                          width: ScreenUtilHelper.width(1),
                          height: ScreenUtilHelper.height(24.0),
                          color: AppColors.blackDisabled,
                        ),
                        _buildTabItem(
                          context,
                          'Payments',
                          2,
                          state.selectedTabIndex == 2,
                        ),
                      ],
                    ),
                  ),
                ),
                _buildCurrentTabContent(state),
              ],
            );
          }
          return const Center(
            child: Text(
              "An unexpected error occurred. Please restart the app.",
            ),
          );
        },
      ),
      floatingActionButton: BlocBuilder<StaffScreenBloc, StaffScreenState>(
        builder: (context, state) {
          if (state is StaffScreenLoaded && state.selectedTabIndex == 0) {
            return SizedBox(
              width: ScreenUtilHelper.width(100),
              height: ScreenUtilHelper.height(30),
              child: ElevatedButton.icon(
                onPressed: ()=>context.push(AppRoutes.addHostelStaff),
                icon: Icon(Icons.add, size: ScreenUtilHelper.scaleAll(18)),
                label: Text(
                  'Add',
                  style: AppStyles.bodyEmphasis,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryContrast,
                  foregroundColor: AppColors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(ScreenUtilHelper.radius(6)),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.width(12),
                    vertical: ScreenUtilHelper.height(4),
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}