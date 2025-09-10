// filename: timetable_management_screen.dart

import 'package:edudibon_flutter_bloc/admin_module/timetable&exam_scheduling/screens/timetable_management_Screen.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ✅ Imports for child screens
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';
import 'substituion_screen.dart' show SubstitutionScreen;
import 'updated_timetable_screen.dart' show UpdateTimetableScreen;
import 'view_timetable_screen.dart' show ViewTimetableScreen;

class TimetableManagementScreen extends StatefulWidget {
  const TimetableManagementScreen({super.key});

  @override
  State<TimetableManagementScreen> createState() =>
      _TimetableManagementScreenState();
}

class _TimetableManagementScreenState
    extends State<TimetableManagementScreen> {
  int selectedIndex = 0;
  List<Map<String, String?>>? _timetableData;

  // ✅ State variables to manage the UI flow
  bool _isEditingTimetable = false;
  String? _selectedClass;
  final List<String> _classOptions = ['Class VIII', 'Class IX', 'Class X'];

  final List<String> options = [
    'Update Timetable',
    'View Timetable',
    'Substitution',
  ];

  void _updateTimetableData(List<Map<String, String?>> data) {
    setState(() {
      _timetableData = data;
      _isEditingTimetable = false;
      selectedIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(16),
                  vertical: ScreenUtilHelper.height(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/edudibon.png',
                    height: ScreenUtilHelper.height(30),
                  ),
                  const Icon(
                    CupertinoIcons.bell,
                    size: 28,
                  ),
                ],
              ),
            ),

            // Back arrow and Title
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(16),
                  vertical: ScreenUtilHelper.height(8)),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => GoRouter.of(context).pop(),
                    child: const Icon(CupertinoIcons.back,
                        size: 24),
                  ),
                  SizedBox(width: ScreenUtilHelper.width(8)),
                  Text(
                    "Timetable Management",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: ScreenUtilHelper.height(16)),

            // Custom Tab Bar
            Container(
              decoration:  BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.parchment),
                ),
              ),
              child: Row(
                children: List.generate(options.length, (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          _isEditingTimetable = false; // Reset on tab switch
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? AppColors.bluishLightBackgroundshilu
                              : AppColors.white,
                          border: Border(
                            bottom: BorderSide(
                              color: selectedIndex == index
                                  ? AppColors.primaryDark
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            options[index],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: AppStyles.weight.emphasis,
                              color: selectedIndex == index
                                  ? AppColors.primaryDark
                                  : AppColors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: ScreenUtilHelper.height(24)),

            Expanded(
              child: getSelectedWidget(),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Helper function to build the class selection UI
  Widget _buildClassSelectionView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: DropdownButtonFormField<String>(
              value: _selectedClass,
              hint: const Text('Select Class'),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              items: _classOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedClass = newValue;
                });
              },
            ),
          ),
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextButton(
              onPressed: () {
                if (_selectedClass != null) {
                  setState(() {
                    _isEditingTimetable = true; // Switch to editor view
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a class first.')),
                  );
                }
              },
              child: Text(
                'Show Timetable',
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Main logic to switch between widgets
  Widget getSelectedWidget() {
    switch (selectedIndex) {
      case 0:
        if (_isEditingTimetable) {
          return UpdateTimetableScreen(
            className: _selectedClass!,
            onTimetableSaved: _updateTimetableData,
            onCancel: () {
              setState(() {
                _isEditingTimetable = false; // Go back to selection view
              });
            },
          );
        } else {
          return _buildClassSelectionView(); // Show dropdown UI
        }
      case 1:
        return _timetableData != null
            ? ViewTimetableScreen(timetableData: _timetableData!)
            : const Center(
          child: Text('No timetable data available.',
            textAlign: TextAlign.center,
          ),
        );
      case 2:
        return const SubstitutionScreen();
      default:
        return const SizedBox();
    }
  }
}