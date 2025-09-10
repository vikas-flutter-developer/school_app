import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../bloc/mail_bloc.dart';
import '../widgets/mail_tab_widget.dart';
import '../widgets/schedule_tab_widget.dart';
import '../../../../core/utils/screen_util_helper.dart'; // Add this import

class MailScreen extends StatefulWidget {
  const MailScreen({super.key});

  @override
  State<MailScreen> createState() => _MailScreenScreenScheduleState();
}

class _MailScreenScreenScheduleState extends State<MailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = 0; // Start on Mail tab

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
    // Initialize the screen util helper
    ScreenUtilHelper.init(context);

    return BlocProvider(
      create: (context) => MailBloc(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.width(16), // Scaled padding
            ),
            child: Container(
              height: ScreenUtilHelper.height(40), // Scaled height
              color: AppColors.accentLight,
              child: Row(
                children: [
                  SizedBox(
                    width: ScreenUtilHelper.width(44), // Scaled width
                    height: ScreenUtilHelper.height(40), // Scaled height
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.primaryDarker,
                        size: ScreenUtilHelper.width(20), // Scaled icon size
                      ),
                      onPressed: ()=> GoRouter.of(context).pop(),
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      splashRadius: ScreenUtilHelper.width(20), // Scaled splash radius
                    ),
                  ),
                  Expanded(
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: AppColors.transparent,
                      labelColor: AppColors.primaryDarker,
                      unselectedLabelColor: AppColors.graphite,
                      labelStyle: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(16), // Scaled font size
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(16), // Scaled font size
                        fontWeight: FontWeight.w500,
                      ),
                      indicator: const BoxDecoration(),
                      dividerColor: AppColors.transparent,
                      labelPadding: EdgeInsets.zero,
                      tabs: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Mail'),
                            SizedBox(width: ScreenUtilHelper.width(50)), // Scaled spacing
                            const VerticalDivider(
                              color: AppColors.blackDivider,
                              thickness: 3.0,
                              width: 20.0, // Adjust width if needed
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: ScreenUtilHelper.width(8)),
                          child: const Tab(text: 'Schedule Mail'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body:
        TabBarView(
          controller: _tabController,
          children:  [MailTabWidget(),
            ScheduleTabWidget() ],
        ),
      ),
    );
  }
}