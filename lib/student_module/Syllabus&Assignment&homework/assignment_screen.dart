import 'package:go_router/go_router.dart';

import '../../../core/utils/app_decorations.dart';
import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';
import 'custom/assignment_container.dart';
import 'custom/toggle.dart';
import 'homework-screen.dart';
import '../../../core/utils/screen_util_helper.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  _AssignmentScreenState createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  bool _isAssignment = true;

  void _handleToggleChanged(bool isAssignment) {
    setState(() {
      _isAssignment = isAssignment;
    });
    print('Selected: \${_isAssignment ? "Assignments" : "Homework"}');
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leadingWidth: ScreenUtilHelper.scaleWidth(120),
        leading: Padding(
          padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(12.0)),
          child: Image.asset(
            'assets/images/edudibon.png',
            height: ScreenUtilHelper.scaleHeight(50),
            width: ScreenUtilHelper.scaleWidth(100),
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.scaleWidth(16.0),
              vertical: ScreenUtilHelper.scaleHeight(8.0),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    context.pop();
                  },
                ),
                Expanded(
                  child: SizedBox(
                    height: ScreenUtilHelper.scaleHeight(50),
                    child: AssignmentHomeworkToggle(
                      onToggleChanged: _handleToggleChanged,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(10.0)),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: ScreenUtilHelper.scaleHeight(10),
                ),
                fillColor: AppColors.parchment,
                filled: true,
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.mic),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    ScreenUtilHelper.scaleRadius(AppDecorations.normalRadius.topLeft.x),
                  ),
                ),
              ),
            ),
          ),
          if (_isAssignment)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(8.0),
              ),
              child: Row(
                children: [
                  _buildFilterContainer(Icon(Icons.filter_alt_rounded, color: AppColors.slate)),
                  SizedBox(width: ScreenUtilHelper.scaleWidth(8.0)),
                  _buildFilterContainer(Row(
                    children: [
                      Text('Completed', style: TextStyle(color: AppColors.slate)),
                      Icon(Icons.keyboard_arrow_down, color: AppColors.slate),
                    ],
                  )),
                  SizedBox(width: ScreenUtilHelper.scaleWidth(8.0)),
                  _buildFilterContainer(Row(
                    children: [
                      Text('Pending', style: TextStyle(color: AppColors.slate)),
                      Icon(Icons.keyboard_arrow_down, color: AppColors.slate),
                    ],
                  )),
                ],
              ),
            ),
          Expanded(
            child: _isAssignment ? _buildAssignmentsScreen() : HomeworkScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterContainer(Widget child) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.scaleWidth(12.0),
        vertical: ScreenUtilHelper.scaleHeight(8.0),
      ),
      decoration: BoxDecoration(
        color: AppColors.parchment,
        borderRadius: BorderRadius.circular(
          ScreenUtilHelper.scaleRadius(AppDecorations.normalRadius.topLeft.x),
        ),
      ),
      child: child,
    );
  }

  Widget _buildAssignmentsScreen() {
    return ListView(
      children: [
        AssignmentContainer(
          title: 'Assignment 1',
          issueDate: '20/07/2025',
          description:
          'Description of the assignment Lorem ipsum dolor sit almet ,\nconsecteur adipiscing elit, sed do siudmod tempor \nincidunt ut labore',
          lastDate: '23/07/2025',
        ),
        AssignmentContainer(
          title: 'Assignment 2',
          issueDate: '21/07/2025',
          description:
          'Description of the assignment Lorem ipsum dolor sit almet ,\nconsecteur adipiscing elit, sed do siudmod tempor \nincidunt ut labore',
          lastDate: '24/07/2025',
        ),
        AssignmentContainer(
          title: 'Assignment 3',
          issueDate: '22/07/2025',
          description:
          'Description of the assignment Lorem ipsum dolor sit almet ,\nconsecteur adipiscing elit, sed do siudmod tempor \nincidunt ut labore',
          lastDate: '25/07/2025',
        ),
      ],
    );
  }
}
