import 'package:go_router/go_router.dart';

import '../../../core/utils/app_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_styles.dart';
import '../../routes/app_routes.dart';
import 'bloc/bus_tracking1_bloc.dart';
import 'bloc/bus_tracking1_event.dart';
import 'bloc/bus_tracking1_state.dart';
import 'live_bus_tracking_screen.dart';
import '../../core/utils/screen_util_helper.dart'; // Make sure this import is correct

class BusTrackingScreen extends StatelessWidget {
  const BusTrackingScreen({super.key});

  final List<String> _busRoutes = const [
    'Bus route No 1',
    'Bus route No 2',
    'Bus route No 3',
    'Bus route No 4',
    'Bus route No 5',
    'Bus route No 6',
  ];

  @override
  Widget build(BuildContext context) {
    // Initialize screen util
    ScreenUtilHelper.init(context);

    final statusBarHeight = MediaQuery.of(context).padding.top;

    final headingFontSize = ScreenUtilHelper.fontSize(16);
    final titleFontSize = ScreenUtilHelper.fontSize(18);
    final iconSize = ScreenUtilHelper.width(24);
    final verticalSpace = ScreenUtilHelper.height(16);
    final horizontalPadding = ScreenUtilHelper.width(16);

    return BlocProvider(
      create: (context) => BusTracking1Bloc(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(statusBarHeight + kToolbarHeight),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.white,
            elevation: 0.5,
            title: Padding(
              padding: EdgeInsets.only(top: statusBarHeight),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/edudibon.png',
                    height: ScreenUtilHelper.height(24),
                  ),
                  const Spacer(),
                  Stack(
                    children: [
                      Icon(Icons.notifications_none, size: iconSize),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            '3',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: ScreenUtilHelper.fontSize(12),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: BlocBuilder<BusTracking1Bloc, BusTracking1State>(
          builder: (context, state) {
            String selectedBusNumber = 'Select Bus Number';
            bool isDropdownVisible = false;

            if (state is SelectedBusNumberChanged) {
              selectedBusNumber = state.selectedBusNumber;
            }
            if (state is BusNumberSelectionVisible) {
              isDropdownVisible = true;
            }
            if (state is BusNumberSelectionHidden) {
              isDropdownVisible = false;
            }

            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: verticalSpace,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: Icon(Icons.arrow_back_ios_new, size: iconSize),
                          ),
                          SizedBox(width: ScreenUtilHelper.width(8)),
                          Text(
                            'Bus Tracking',
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: GestureDetector(
                        onTap: () {
                          context.read<BusTracking1Bloc>().add(ToggleBusNumberSelection());
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtilHelper.width(12),
                            vertical: ScreenUtilHelper.height(12),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.ivory,
                            borderRadius: AppDecorations.normalRadius,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedBusNumber,
                                style: TextStyle(
                                  fontSize: headingFontSize,
                                  color: AppColors.primaryMedium,
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down,
                                  color: AppColors.primaryMedium, size: iconSize),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                if (isDropdownVisible)
                  Positioned(
                    top: ScreenUtilHelper.height(140),
                    left: horizontalPadding,
                    right: horizontalPadding,
                    child: Material(
                      elevation: 2,
                      color: const Color(0xFFEDECF8),
                      borderRadius: AppDecorations.normalRadius,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _busRoutes.map((route) {
                          return InkWell(
                            onTap: () {
                              context.read<BusTracking1Bloc>().add(SelectBusNumber(route));
                              context.push(AppRoutes.liveRoute,extra: route);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtilHelper.width(12),
                                vertical: ScreenUtilHelper.height(8),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    route,
                                    style: TextStyle(
                                      fontSize: headingFontSize,
                                      color: AppColors.blackMediumEmphasis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
