import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/bloc/syllbus/syllabus_bloc.dart' show LoadSyllabus, SyllabusBloc;
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/bloc/syllbus/syllabus_state.dart' show SyllabusError, SyllabusLoaded, SyllabusLoading, SyllabusState;
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/screens/study_material_screen.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/widgets/custom_app_bar.dart' show CustomAppBar;
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/widgets/custom_filter_row.dart' show CustomFilterButton;
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/widgets/custom_search_bar.dart' show CustomSearchBar;
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/widgets/custom_tab_bar.dart' show CustomTabBar;
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/widgets/syllabus_card.dart' show SyllabusCard;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import 'assignment_screen.dart';

class TeacherSyllabusScreen extends StatefulWidget {
  const TeacherSyllabusScreen({super.key});

  @override
  _TeacherSyllabusScreenState createState() => _TeacherSyllabusScreenState();
}

class _TeacherSyllabusScreenState extends State<TeacherSyllabusScreen> {
  int _selectedIndex = 1;
  final List<String> _tabs = ['Assignment', 'Syllabus', 'Study Material'];
  final PageController _pageController = PageController(initialPage: 1);

  @override
  void initState() {
    super.initState();
    context.read<SyllabusBloc>().add(LoadSyllabus());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          CustomTabBar(
            tabs: _tabs,
            selectedIndex: _selectedIndex,
            onTabSelected: (index) {
              setState(() {
                _selectedIndex = index;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            },
          ),
          if (_selectedIndex == 1) _buildSyllabusFilters(),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: const [
                AssignmentScreen(),
                SyllabusContentScreen(),
                StudyMaterialScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyllabusFilters() {
    return Padding(
      padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(8.0)),
      child: Column(
        children: [
          const CustomSearchBar(),
          SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
          Padding(
            padding: EdgeInsets.only(right: ScreenUtilHelper.scaleWidth(8.0)),
            child: Row(
              children: [
                const CustomFilterButton(),
                SizedBox(width: ScreenUtilHelper.scaleWidth(5)),
                _buildDropdown('Subject'),
                SizedBox(width: ScreenUtilHelper.scaleWidth(5)),
                _buildDropdown('Class'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String hintText) {
    return InkWell(
      onTap: () => print('$hintText Dropdown tapped!'),
      child: Container(
        width: ScreenUtilHelper.scaleWidth(94),
        height: ScreenUtilHelper.scaleHeight(28),
        padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(8.0)),
        decoration: BoxDecoration(
          color: AppColors.linen,
          borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(2.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(hintText, style: AppStyles.font14),
            Icon(Icons.arrow_drop_down, size: ScreenUtilHelper.scaleWidth(20.0)),
          ],
        ),
      ),
    );
  }
}

class SyllabusContentScreen extends StatelessWidget {
  const SyllabusContentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyllabusBloc, SyllabusState>(
      builder: (context, state) {
        if (state is SyllabusLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SyllabusError) {
          return Center(child: Text(state.message));
        } else if (state is SyllabusLoaded) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(8.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
                ...state.syllabusItems.map(
                      (item) => Column(
                    children: [
                      SyllabusCard(item: item),
                      SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
                    ],
                  ),
                ).toList(),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
