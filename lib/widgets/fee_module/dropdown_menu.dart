import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_routes.dart';
import '../../student_module/fees_details/transaction_status.dart';

class AppBarDropdown extends StatelessWidget {
  const AppBarDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String result) {
        if (result == 'Fees Due') {
          context.push(AppRoutes.feeDue);
        } else if (result == 'Transaction Status') {
          context.push(AppRoutes.feeTransactions);
        } else if (result == 'Help') {
          // Implement navigation if needed
        }
      },
      itemBuilder:
          (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Fees Due',
              child: Text(
                'Fees Due',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'Transaction Status',
              child: Text(
                'Transaction Status',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'Help',
              child: Text(
                'Help',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
      icon: const Icon(Icons.more_vert, size: 30),
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Color.fromRGBO(152, 152, 152, 1),
          width: 1.0,
        ),
      ),
      constraints: const BoxConstraints(
        minWidth: 183,
        maxWidth: 183,
        minHeight: 178,
        maxHeight: 178,
      ),
      color: const Color.fromRGBO(255, 255, 255, 1),
    );
  }
}
