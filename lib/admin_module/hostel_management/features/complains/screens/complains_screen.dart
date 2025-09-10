import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../bloc/complains_bloc/complains_bloc.dart';
import '../widgets/staff_tab_content.dart';
import '../widgets/student_tab_content.dart';

class ComplainsScreen extends StatelessWidget {
  const ComplainsScreen({super.key});

  Widget _buildTabItem(BuildContext context, String title, int index) {
    final complainsBloc = BlocProvider.of<ComplainsBloc>(context);
    final isActive = complainsBloc.state.selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          complainsBloc.add(TabChanged(index));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: AppStyles.size.body,
                fontWeight: isActive ? AppStyles.weight.heading : AppStyles.weight.regular,
                color: isActive ? AppColors.secondaryDarkest : AppColors.stone,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return BlocProvider(
      create: (context) => ComplainsBloc()..add(LoadComplains()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.blackMediumEmphasis,
              size: ScreenUtilHelper.scaleAll(20),
            ),
            onPressed: () => context.pop(),
          ),
          title: Image.asset(
            "assets/images/edudibon.png",
            width: ScreenUtilHelper.width(159),
            height: ScreenUtilHelper.height(39),
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
                      BorderRadius.all(Radius.circular(ScreenUtilHelper.radius(8))),
                    ),
                    constraints: BoxConstraints(
                      minWidth: ScreenUtilHelper.width(16),
                      minHeight: ScreenUtilHelper.height(16),
                    ),
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: ScreenUtilHelper.fontSize(10),
                        fontWeight: FontWeight.bold,
                      ),
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
                          hintStyle: TextStyle(
                            color: AppColors.silver,
                            fontSize: ScreenUtilHelper.fontSize(15),
                          ),
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
              child: Container(
                width: double.infinity,
                height: ScreenUtilHelper.height(41),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(ScreenUtilHelper.radius(9))),
                  color: const Color.fromRGBO(246, 248, 255, 1),
                ),
                child: BlocBuilder<ComplainsBloc, ComplainsState>(
                  builder: (context, state) {
                    return Row(
                      children: <Widget>[
                        _buildTabItem(context, 'Student', 0),
                        Container(
                          width: ScreenUtilHelper.width(1),
                          height: ScreenUtilHelper.height(24.0),
                          color: AppColors.blackDisabled,
                        ),
                        _buildTabItem(context, 'Staff', 1),
                      ],
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ComplainsBloc, ComplainsState>(
                builder: (context, state) {
                  return IndexedStack(
                    index: state.selectedTabIndex,
                    children: const [StudentTabContent(), StaffTabContent()],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}