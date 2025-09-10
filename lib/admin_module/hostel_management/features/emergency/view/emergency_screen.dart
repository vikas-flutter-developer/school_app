import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class EmergencyContact {
  final String name;
  final String number;
  final bool isService;

  EmergencyContact({required this.name, required this.number, this.isService = false});
}

class EmergencyScreen extends StatelessWidget {
  EmergencyScreen({super.key});

  final List<EmergencyContact> _emergencyContacts = [
    EmergencyContact(name: 'Ambulance', number: '102', isService: true),
    EmergencyContact(name: 'Police', number: '100', isService: true),
    EmergencyContact(name: 'Fire Brigade', number: '101', isService: true),
    EmergencyContact(name: 'Women Helpline', number: '1091', isService: true),
    EmergencyContact(name: 'Madhav Palvi', number: '+91 98765 66788'),
    EmergencyContact(name: 'Avinash Pratap', number: '+91 98765 66788'),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: ScreenUtilHelper.scaleAll(22)), onPressed: () => context.pop()),
          title: Text(
              'Emergency',
              style: AppStyles.display.copyWith(color: theme.primaryColor)
          ),
          actions: [
            IconButton(icon: Icon(Icons.search, color: theme.primaryColor, size: ScreenUtilHelper.scaleAll(24)), onPressed: (){}),
            IconButton(icon: Icon(Icons.filter_list, color: theme.primaryColor, size: ScreenUtilHelper.scaleAll(24)), onPressed: (){}),
            IconButton(icon: Icon(Icons.menu, color: theme.primaryColor, size: ScreenUtilHelper.scaleAll(24)), onPressed: (){}),
          ]
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(16),
            vertical: ScreenUtilHelper.height(16)
        ),
        itemCount: _emergencyContacts.length,
        itemBuilder: (context, index) {
          final contact = _emergencyContacts[index];
          return Card(
            color: theme.colorScheme.surface.withOpacity(0.8),
            child: ListTile(
              title: Text(
                  contact.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtilHelper.fontSize(16)
                  )
              ),
              subtitle: Text(
                  contact.number,
                  style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: ScreenUtilHelper.fontSize(14)
                  )
              ),
              trailing: IconButton(
                icon: Icon(
                    Icons.phone_outlined,
                    color: theme.primaryColor,
                    size: ScreenUtilHelper.scaleAll(24)
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Call ${contact.number} (Not Implemented)")));
                },
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: ScreenUtilHelper.height(8)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Create new contact (Not Implemented)")));
        },
        label: Text(
            'Create',
            style: TextStyle(fontSize: ScreenUtilHelper.fontSize(16),color: AppColors.white)
        ),
        icon: Icon(Icons.add, size: ScreenUtilHelper.scaleAll(24),color: AppColors.white),
        backgroundColor: theme.primaryColor,
      ),
    );
  }
}