import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import 'package:go_router/go_router.dart';

class TeacherSyllableUnitScreen extends StatefulWidget {
  final int notificationCount;
  final Map<String, dynamic> topic;

  const TeacherSyllableUnitScreen({
    Key? key,
    required this.topic,
    this.notificationCount = 3, required String subjectTitle,
  }) : super(key: key);

  @override
  _MyTeacherSyllableUnitScreenState createState() =>
      _MyTeacherSyllableUnitScreenState();
}

class _MyTeacherSyllableUnitScreenState
    extends State<TeacherSyllableUnitScreen> {
  List<SyllableUnit> syllableUnits = List.generate(
    7,
        (index) => SyllableUnit(
      id: index + 1,
      text:
      '${index + 1}. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            title: Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: ScreenUtilHelper.scaleWidth(150),
                    height: ScreenUtilHelper.scaleHeight(39),
                    margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.scaleWidth(8),
                    ),
                    child: Image.asset(
                      'assets/images/edudibon.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            actions: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none),
                    onPressed: () {},
                  ),
                  if (widget.notificationCount > 0)
                    Positioned(
                      right: ScreenUtilHelper.scaleWidth(15),
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(4)),
                        decoration: const BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                        ),
                        constraints: BoxConstraints(
                          minWidth: ScreenUtilHelper.scaleWidth(16),
                          minHeight: ScreenUtilHelper.scaleHeight(16),
                        ),
                        child: Center(
                          child: Text(
                            '${widget.notificationCount}',
                            style: AppStyles.whiteFont10,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(ScreenUtilHelper.scaleHeight(56)),
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.only(
                  left: ScreenUtilHelper.scaleWidth(8),
                  right: ScreenUtilHelper.scaleWidth(8),
                  bottom: ScreenUtilHelper.scaleHeight(8),
                ),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => GoRouter.of(context).pop(),
                    ),
                    Text(
                      widget.topic['title'],
                      style: AppStyles.headingLNoColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.scaleWidth(8),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final unit = syllableUnits[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: ScreenUtilHelper.scaleHeight(25),
                    ),
                    child: _buildSyllableUnitItem(index, unit),
                  );
                },
                childCount: syllableUnits.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyllableUnitItem(int index, SyllableUnit unit) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: ScreenUtilHelper.scaleWidth(313),
          height: ScreenUtilHelper.scaleHeight(88),
          decoration: BoxDecoration(
            color: AppColors.attendanceHoliday,
            borderRadius: BorderRadius.circular(
              ScreenUtilHelper.scaleRadius(12),
            ),
          ),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: ScreenUtilHelper.scaleWidth(300),
                height: ScreenUtilHelper.scaleHeight(88),
                decoration: const BoxDecoration(color: AppColors.ivory),
                padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(8)),
                child: Text(
                  unit.text,
                  style: AppStyles.body12Black,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: ScreenUtilHelper.scaleWidth(20)),
        GestureDetector(
          onTap: () {
            setState(() {
              syllableUnits[index].isChecked = !syllableUnits[index].isChecked;
            });
          },
          child: Container(
            width: ScreenUtilHelper.scaleWidth(31),
            height: ScreenUtilHelper.scaleWidth(31),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: unit.isChecked
                  ? AppColors.success
                  : AppColors.blackMediumEmphasis,
            ),
            child: Center(
              child: unit.isChecked
                  ? const Icon(Icons.check, color: AppColors.white)
                  : Container(
                width: ScreenUtilHelper.scaleWidth(31),
                height: ScreenUtilHelper.scaleWidth(31),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.cloud,
                    width: ScreenUtilHelper.scaleWidth(2),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SyllableUnit {
  final int id;
  final String text;
  bool isChecked;

  SyllableUnit({
    required this.id,
    required this.text,
    this.isChecked = false,
  });
}
