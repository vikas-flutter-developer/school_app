// filename: view_timetable_screen.dart

import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart'; // Apne AppColors ka path yahan daalein

class ViewTimetableScreen extends StatefulWidget {
  final List<Map<String, String?>> timetableData;

  const ViewTimetableScreen({super.key, required this.timetableData});

  @override
  State<ViewTimetableScreen> createState() => _ViewTimetableScreenState();
}

class _ViewTimetableScreenState extends State<ViewTimetableScreen> {
  String _selectedDay = 'Wed'; // Initially selected day
  final List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  @override
  Widget build(BuildContext context) {
    // Dummy data for demonstration, aap ise widget.timetableData se replace karenge
    final periods = List.generate(8, (index) {
      return {
        'period': 'Period ${index + 1}',
        'time': '8:30 AM\n9:15 AM',
        'subject': 'English',
        'teacher': 'S. Divya'
      };
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // ✅ Top section with Day Selector
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _days.length,
              itemBuilder: (context, index) {
                final day = _days[index];
                final isSelected = day == _selectedDay;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDay = day;
                    });
                  },
                  child: Container(
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryDark : AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? AppColors.primaryDark : Colors.grey.shade400,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          color: isSelected ? AppColors.white : AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // ✅ Main timetable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Timetable header
                  _buildTimetableHeader(),
                  const SizedBox(height: 16),

                  // List of periods
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: periods.length,
                    itemBuilder: (context, index) {
                      return _buildPeriodCard(periods[index]);
                    },
                    separatorBuilder: (context, index) {
                      // Show BREAK after the 5th period
                      if (index == 4) {
                        return _buildBreakCard();
                      }
                      return const SizedBox(height: 12);
                    },
                  ),
                ],
              ),
            ),
          ),

          // ✅ Download Button at the bottom
          _buildDownloadButton(),
        ],
      ),
    );
  }

  // Helper function to build the timetable header
  Widget _buildTimetableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          )
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Timetable', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Class X A', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Wednesday Jan 2025', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Helper function to build each period card
  Widget _buildPeriodCard(Map<String, String?> periodData) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          )
        ],
      ),
      child: Row(
        children: [
          // Period Number
          Expanded(
            flex: 2,
            child: Text(
              periodData['period'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),

          // Time
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              decoration: BoxDecoration(
                color: AppColors.bluishLightBackgroundshilu.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                periodData['time'] ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Subject and Teacher
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.bluishLightBackgroundshilu.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    periodData['subject'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    periodData['teacher'] ?? '',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function for the BREAK card
  Widget _buildBreakCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          )
        ],
      ),
      child: const Center(
        child: Text(
          'BREAK',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 2),
        ),
      ),
    );
  }

  // Helper function for the Download button
  Widget _buildDownloadButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton.icon(
        onPressed: () {
          // Add download logic here
        },
        icon: const Icon(Icons.download_for_offline_outlined),
        label: const Text('Download'),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}