import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../bloc/issue_item_bloc.dart';
import '../widgets/id_cards_tab_content.dart';
import '../widgets/keys_tab_content.dart';
import '../widgets/others_tab_content.dart';
import '../widgets/tab_item_widget.dart';

class IssueItemScreen extends StatelessWidget {
  const IssueItemScreen({super.key});

  Widget _buildCurrentTabContent(int selectedTabIndex) {
    switch (selectedTabIndex) {
      case 0:
        return const IDCardsTabContent();
      case 1:
        return const KeysTabContent();
      case 2:
        return const OthersTabContent();
      default:
        return const OthersTabContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return BlocProvider(
      create: (context) => IssueItemBloc(),
      child: Scaffold(
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
        body: Column(
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
                        decoration: InputDecoration(
                          hintText: 'Search by name, room',
                          hintStyle: AppStyles.bodySmall.copyWith(color: AppColors.silver),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.cloud,
                            size: ScreenUtilHelper.scaleAll(22),
                          ),
                          suffixIcon: Icon(
                            Icons.mic,
                            color: AppColors.slate,
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
                            const BorderSide(color: AppColors.info),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                ScreenUtilHelper.radius(12.0)),
                            borderSide: BorderSide(
                              color: AppColors.success,
                              width: ScreenUtilHelper.width(2.0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                ScreenUtilHelper.radius(12.0)),
                            borderSide:
                             BorderSide(color: AppColors.cloud),
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
                        borderRadius:
                        BorderRadius.circular(ScreenUtilHelper.radius(9)),
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
              child: BlocBuilder<IssueItemBloc, IssueItemState>(
                builder: (context, state) {
                  return Container(
                    width: double.infinity,
                    height: ScreenUtilHelper.height(41),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(ScreenUtilHelper.radius(9)),
                      color: AppColors.ivory,
                    ),
                    child: Row(
                      children: <Widget>[
                        TabItemWidget(
                          title: 'ID Cards',
                          index: 0,
                          isActive: state.selectedTabIndex == 0,
                          onTap: () {
                            context.read<IssueItemBloc>().add(
                              const TabChanged(0),
                            );
                          },
                        ),
                        Container(
                          width: ScreenUtilHelper.width(1),
                          height: ScreenUtilHelper.height(24.0),
                          color: AppColors.blackDisabled,
                        ),
                        TabItemWidget(
                          title: 'Keys',
                          index: 1,
                          isActive: state.selectedTabIndex == 1,
                          onTap: () {
                            context.read<IssueItemBloc>().add(
                              const TabChanged(1),
                            );
                          },
                        ),
                        Container(
                          width: ScreenUtilHelper.width(1),
                          height: ScreenUtilHelper.height(24.0),
                          color: AppColors.blackDisabled,
                        ),
                        TabItemWidget(
                          title: 'Others',
                          index: 2,
                          isActive: state.selectedTabIndex == 2,
                          onTap: () {
                            context.read<IssueItemBloc>().add(
                              const TabChanged(2),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<IssueItemBloc, IssueItemState>(
                builder: (context, state) {
                  return _buildCurrentTabContent(state.selectedTabIndex);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}