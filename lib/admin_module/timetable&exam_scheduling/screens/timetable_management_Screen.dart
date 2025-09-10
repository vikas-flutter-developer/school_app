// filename: updated_timetable_screen.dart

import 'package:flutter/material.dart';

// ✅ Imports for helpers
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';

class UpdateTimetableScreen extends StatefulWidget {
  // ✅ Parameters passed from the parent screen
  final String className;
  final Function(List<Map<String, String?>>) onTimetableSaved;
  final VoidCallback onCancel;

  const UpdateTimetableScreen({
    super.key,
    required this.className,
    required this.onTimetableSaved,
    required this.onCancel,
  });

  @override
  State<UpdateTimetableScreen> createState() => _UpdateTimetableScreenState();
}

class _UpdateTimetableScreenState extends State<UpdateTimetableScreen> {
  final List<String> subjects = ['Mathematics', 'English', 'Science', 'Computer Science', 'Geography', 'History'];
  final List<String> teachers = ['Raman K', 'Sita P', 'Anil M', 'Priya S'];

  List<String?> selectedSubjects = List.generate(6, (_) => null);
  List<String?> selectedTeachers = List.generate(6, (_) => null);
  List<TextEditingController> remarksControllers = List.generate(6, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in remarksControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool _canSave() {
    for (int i = 0; i < 6; i++) {
      if (selectedSubjects[i] == null || selectedTeachers[i] == null) {
        return false;
      }
    }
    return true;
  }

  void _onSave() {
    List<Map<String, String?>> timetableData = List.generate(6, (i) => {
      'period': (i + 1).toString(),
      'subject': selectedSubjects[i],
      'teacher': selectedTeachers[i],
      'remark': remarksControllers[i].text,
    });
    widget.onTimetableSaved(timetableData);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.ivory,
              border: Border.all(color: AppColors.black),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                '${widget.className} - Monday', // ✅ Show the class name from parent
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          ListView.builder(
            itemCount: 6,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final isEven = index % 2 == 0;
              final periodBackgroundColor = isEven ? AppColors.bluishLightBackgroundshilu : AppColors.white;
              final contentBackgroundColor = isEven ? AppColors.white : AppColors.bluishLightBackgroundshilu;
              const defaultFontSize = 14.0;
              const dropdownPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 10);

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: periodBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.silver),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 60,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Period ${index + 1}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: defaultFontSize,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: contentBackgroundColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField<String>(
                                      value: selectedSubjects[index],
                                      isExpanded: true,
                                      decoration: const InputDecoration(
                                        contentPadding: dropdownPadding,
                                        border: OutlineInputBorder(),
                                        isDense: true,
                                      ),
                                      hint: const Text(
                                        'Select Subject',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: defaultFontSize),
                                      ),
                                      items: subjects.map((s) => DropdownMenuItem(
                                        value: s,
                                        child: Text(s, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: defaultFontSize)),
                                      )).toList(),
                                      onChanged: (v) => setState(() => selectedSubjects[index] = v),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: DropdownButtonFormField<String>(
                                      value: selectedTeachers[index],
                                      isExpanded: true,
                                      decoration: const InputDecoration(
                                        contentPadding: dropdownPadding,
                                        border: OutlineInputBorder(),
                                        isDense: true,
                                      ),
                                      hint: const Text(
                                        'Select Teacher',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: defaultFontSize),
                                      ),
                                      items: teachers.map((t) => DropdownMenuItem(
                                        value: t,
                                        child: Text(t, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: defaultFontSize)),
                                      )).toList(),
                                      onChanged: (v) => setState(() => selectedTeachers[index] = v),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: remarksControllers[index],
                                style: const TextStyle(fontSize: defaultFontSize),
                                decoration: const InputDecoration(
                                  hintText: 'Write Remark',
                                  hintStyle: TextStyle(fontSize: defaultFontSize),
                                  border: OutlineInputBorder(),
                                  contentPadding: dropdownPadding,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: widget.onCancel, // ✅ Calls the onCancel function from parent
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Cancel', style: TextStyle(color: Colors.black, fontSize: 14)),
              ),
              ElevatedButton(
                onPressed: _canSave() ? _onSave : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                  disabledBackgroundColor: Colors.grey.shade400,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}