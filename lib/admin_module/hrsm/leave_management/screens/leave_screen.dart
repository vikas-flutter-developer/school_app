import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../../../../teacher_module/leave_management/bloc/leave_bloc/leave_bloc.dart';
import 'LeaveApplicationsScreen.dart';

class LeaveScreen extends StatefulWidget {
  @override
  _LeaveScreenState createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  int _selectedIndex = 0;

  final List<Map<String, String>> teachingList = List.generate(
    4,
        (_) => {'name': 'Rutuja Yawale', 'type': 'Teaching', 'date': '15/03-17/03'},
  );

  final List<Map<String, String>> nonTeachingList = List.generate(
    4,
        (_) => {'name': 'Rutuja Yawale', 'type': 'Non-Teaching', 'date': '15/03-17/03'},
  );

  final List<Map<String, String>> adminList = List.generate(
    4,
        (_) => {'name': 'Rutuja Yawale', 'type': 'Admin', 'date': '15/03-17/03'},
  );

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      buildLeaveHomeScreen(),
      buildLeaveHomeScreen(),
     //Center(child: Text("My Account")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _pages[_selectedIndex],

    );
  }

  Widget buildLeaveHomeScreen() {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leadingWidth: 0,
        leading: const SizedBox.shrink(), // <-- Removes the back arrow icon
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.only(left: ScreenUtilHelper.width(16)),
          child: Image.asset(
            'assets/images/edudibon_logo.png',
            width: ScreenUtilHelper.width(110),
            height: ScreenUtilHelper.height(36),
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ScreenUtilHelper.width(16)),
            child: Icon(
              Icons.notifications_none_outlined,
              color: AppColors.black,
              size: ScreenUtilHelper.width(26),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ScreenUtilHelper.width(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

             //Padding(
              //  padding: EdgeInsets.only(bottom: ScreenUtilHelper.height(8)),
               // child: Row(
                 // children: [
                //  ],
                //),
              //),

              Row(
                children: [GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios, color: AppColors.black),
                ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.width(12),
                        vertical: ScreenUtilHelper.height(8),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.parchment,
                        borderRadius: BorderRadius.circular(
                          ScreenUtilHelper.radius(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: ()=>context.push(AppRoutes.leaveApplications),
                            child: Text(
                              "Today on Leave",
                              style: TextStyle(
                                color: AppColors.primaryMedium,
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtilHelper.fontSize(12),
                              ),
                            ),
                          ),
                          Container(
                            height: ScreenUtilHelper.height(16),
                            width: 1,
                            color: AppColors.parchment,
                          ),
                          Text(
                            "Applications",
                            style: TextStyle(
                              color: AppColors.primaryMedium,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtilHelper.fontSize(12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtilHelper.height(16)),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search.....',
                  hintStyle: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)),
                  prefixIcon: Icon(Icons.search, size: ScreenUtilHelper.width(24)),
                  suffixIcon: Icon(Icons.mic, size: ScreenUtilHelper.width(24)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(12)),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.height(16)),
              Row(
                children: [
                  Container(
                    height: ScreenUtilHelper.height(40),
                    width: ScreenUtilHelper.height(40),
                    decoration: BoxDecoration(
                      color: AppColors.parchment,
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.filter_alt_outlined,
                        color: AppColors.slate,
                        size: ScreenUtilHelper.width(20),
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenUtilHelper.width(8)),
                  Expanded(
                    child: Container(
                      height: ScreenUtilHelper.height(40),
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(8)),
                      decoration: BoxDecoration(
                        color: AppColors.parchment,
                        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: 'Teaching',
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down, size: ScreenUtilHelper.width(20)),
                          style: TextStyle(
                            fontSize: ScreenUtilHelper.fontSize(14),
                            color: AppColors.black,
                          ),
                          items: const [
                            DropdownMenuItem(value: 'Teaching', child: Text('Teaching')),
                            DropdownMenuItem(value: 'Non-Teaching', child: Text('Non-Teaching')),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenUtilHelper.width(8)),
                  Expanded(
                    child: Container(
                      height: ScreenUtilHelper.height(40),
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(8)),
                      decoration: BoxDecoration(
                        color: AppColors.parchment,
                        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: 'Date',
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down, size: ScreenUtilHelper.width(20)),
                          style: TextStyle(
                            fontSize: ScreenUtilHelper.fontSize(14),
                            color: AppColors.black,
                          ),
                          items: const [
                            DropdownMenuItem(value: 'Date', child: Text('Date')),
                            DropdownMenuItem(value: 'Recent', child: Text('Recent')),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtilHelper.height(16)),
              _buildSection("Teaching", teachingList),
              _buildSection("Non - Teaching", nonTeachingList),
              _buildSection("Administration", adminList),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSection(String title, List<Map<String, String>> dataList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ScreenUtilHelper.height(16)),
        Text(
          title,
          style: TextStyle(
            fontSize: ScreenUtilHelper.fontSize(16),
            fontWeight: FontWeight.w600,
          ),
        ),
        ...dataList.map((item) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(6)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item['name']!, style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
                Text(item['type']!, style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
                Text(item['date']!, style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
