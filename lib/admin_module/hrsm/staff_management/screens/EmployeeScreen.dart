import 'package:edudibon_flutter_bloc/admin_module/hrsm/staff_management/bloc/employee_bloc.dart';
import 'package:edudibon_flutter_bloc/admin_module/hrsm/staff_management/model/employee_model.dart';
import 'package:edudibon_flutter_bloc/admin_module/hrsm/staff_management/screens/employee_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/app_routes.dart';
import '../dummy/dumm_data.dart';

class EmployeeScreen extends StatelessWidget {
  EmployeeScreen({super.key});

  final List<EmployeeModel> employees = dummyEmployees;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: ScreenUtilHelper.scaleHeight(15)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(16),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/edudibon1.png',
                    height: ScreenUtilHelper.scaleHeight(25),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.notifications_none_outlined,
                    color: AppColors.black,
                    size: ScreenUtilHelper.scaleWidth(24),
                  ),
                  SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,top: 15),
                  child: GestureDetector(onTap:()=>GoRouter.of(context).pop(),child: Icon(Icons.arrow_back_ios_new, size: ScreenUtilHelper.width(20))),
                ),
                SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtilHelper.scaleHeight(16), left: ScreenUtilHelper.scaleWidth(18)),
                  child: Text(
                    'Employees',
                    style: AppStyles.small.copyWith(fontSize: ScreenUtilHelper.scaleText(16)),
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(16),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search.....',
                  border: InputBorder.none,
                  filled: true,


                  fillColor: const Color(0xFFF1F1F1),

                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.blackHighEmphasis,
                  ),
                  suffixIcon: Icon(
                    Icons.mic,
                    color: AppColors.blackHighEmphasis,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: ScreenUtilHelper.scaleHeight(12),
                    horizontal: ScreenUtilHelper.scaleWidth(16),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              // child: TextField(
              //   decoration: InputDecoration(
              //     hintText: 'Search.....',
              //     border: InputBorder.none,
              //     filled: true,
              //     fillColor: AppColors.frostWhite,
              //     prefixIcon: Icon(
              //       Icons.search,
              //       color: AppColors.blackHighEmphasis,
              //     ),
              //     suffixIcon: Icon(
              //       Icons.mic,
              //       color: AppColors.blackHighEmphasis,
              //     ),
              //     contentPadding: EdgeInsets.symmetric(
              //       vertical: ScreenUtilHelper.scaleHeight(12),
              //       horizontal: ScreenUtilHelper.scaleWidth(16),
              //     ),
              //   ),
              // ),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(16),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.parchment,
                      borderRadius: BorderRadius.circular(
                        ScreenUtilHelper.scaleWidth(12),
                      ),
                    ),
                    padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(8)),
                    child: Icon(
                      Icons.filter_alt_outlined,
                      color: AppColors.slate,
                      size: ScreenUtilHelper.width(20),
                    ),
                  ),
                  SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.scaleWidth(12),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.parchment,
                        borderRadius: BorderRadius.circular(
                          ScreenUtilHelper.scaleWidth(12),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: 'Teaching',
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.black,
                          ),
                          items:
                              <String>['Teaching', 'Non-Teach', 'Admin']
                                  .map(
                                    (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: AppStyles.bodySmall.copyWith(
                                            color: AppColors.blackHighEmphasis,
                                          )),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (String? newValue) {},
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.scaleWidth(12),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.parchment,
                        borderRadius: BorderRadius.circular(
                          ScreenUtilHelper.scaleWidth(12),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: 'Date',
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.black,
                          ),
                          items:
                              <String>['Date', 'Name']
                                  .map(
                                    (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: AppStyles.bodySmall.copyWith(
                                            color: AppColors.blackHighEmphasis,
                                          )),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (String? newValue) {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(24)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(16),
              ),
              child: Center(
                child: Text(
                  'Employee List',
                  style: AppStyles.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.scaleWidth(8),
                ),
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.scaleWidth(5),
                    vertical: ScreenUtilHelper.scaleHeight(5),
                  ),
                  itemCount: employees.length,
                  separatorBuilder:
                      (context, index) =>
                          SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
                  itemBuilder: (context, index) {
                    final employee = employees[index];
                    return GestureDetector(
                      onTap:(){
                        context.push(AppRoutes.employeeProfile,extra: index);
                      },
                      child: Container(
                        padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground, // Violet color
                          // borderRadius: BorderRadius.circular(
                          //   ScreenUtilHelper.scaleWidth(12),
                          // ),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.deepPurple.shade200.withOpacity(0.5),
                          //     blurRadius: 1,
                          //     offset: const Offset(0, 3),
                          //   ),
                          // ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              employee.name,
                              style: AppStyles.bodyMedium.copyWith(
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              employee.role,
                              style: AppStyles.bodyMedium.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(24)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(16),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: ()=>context.push(AppRoutes.addStaff),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryMedium,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        ScreenUtilHelper.scaleWidth(20),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.scaleWidth(24),
                      vertical: ScreenUtilHelper.scaleHeight(12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Create',
                        style: AppStyles.bodySmallBold.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(width: ScreenUtilHelper.scaleWidth(6)),
                      Icon(Icons.add, color: AppColors.white),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Account',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: AppColors.primaryMedium,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}
