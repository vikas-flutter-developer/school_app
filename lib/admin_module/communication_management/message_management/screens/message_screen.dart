import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../bloc/message_bloc.dart';
import '../widgets/schedule_tab_widget.dart';
import '../widgets/sms_tab_widget.dart';
import '../../../../core/utils/screen_util_helper.dart';  // Import the ScreenUtilHelper

class MessageScreenSchedule extends StatefulWidget {
  const MessageScreenSchedule({super.key});

  @override
  State<MessageScreenSchedule> createState() => _MessageScreenScheduleState();
}

class _MessageScreenScheduleState extends State<MessageScreenSchedule>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = 0; // Start on SMS tab

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        print("Switched to tab index: ${_tabController.index}");
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtilHelper
    ScreenUtilHelper.init(context);

    return BlocProvider(
      create: (context) => MessageBloc(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.width(8), // Adjusted padding
            ),
            child: Container(
              height: ScreenUtilHelper.height(40), // Adjusted height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.accentLight,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: ScreenUtilHelper.width(44), // Adjusted width
                    height: ScreenUtilHelper.height(40), // Adjusted height
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.primaryDarkest,
                        size: ScreenUtilHelper.width(20), // Adjusted icon size
                      ),
                      onPressed: ()=>GoRouter.of(context).pop(),
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      splashRadius: ScreenUtilHelper.width(20), // Adjusted splash radius
                    ),
                  ),
                  Expanded(
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: AppColors.transparent,
                      labelColor: AppColors.primaryDark,
                      unselectedLabelColor: AppColors.graphite,
                      labelStyle: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(16), // Adjusted font size
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(16), // Adjusted font size
                        fontWeight: FontWeight.w500,
                      ),
                      indicator: const BoxDecoration(),
                      dividerColor: AppColors.transparent,
                      labelPadding: EdgeInsets.zero,
                      tabs: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('SMS'),
                            SizedBox(width: ScreenUtilHelper.width(50)), // Adjusted width
                            const VerticalDivider(
                              color: AppColors.blackDivider,
                              thickness: 3.0,
                              width: 10.0, // This can remain constant if it doesn’t need scaling
                            ),
                          ],
                        ),
                        // const Tab(text: 'Schedule Message'),
                        Padding(
                          padding: const EdgeInsets.only(right: 26.0),
                          child: Text("Schedule Message"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [SmsTabWidget(), ScheduleTabWidget()],
        ),
      ),
    );
  }
}
