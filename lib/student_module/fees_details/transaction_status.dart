import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_decorations.dart';
import '../../core/utils/screen_util_helper.dart';  // Add the import for responsiveness

class TransactionStatusScreen extends StatelessWidget {
  const TransactionStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtilHelper
    ScreenUtilHelper.init(context);

    final transactionData = [
      {
        'name': 'Naveen Naveen',
        'dateTime': DateTime(2024, 3, 11, 13, 40, 8),
        'status': 'Paid',
        'amount': 25000.00,
        'initial': 'N',
        'isHighlighted': false,
      },
      {
        'name': 'Naveen Naveen',
        'dateTime': DateTime(2024, 3, 11, 13, 40, 8),
        'status': 'Paid',
        'amount': 25000.00,
        'initial': 'N',
        'isHighlighted': true,
      },
    ];

    Widget buildTransactionItem({
      required String name,
      required DateTime dateTime,
      required String status,
      required double amount,
      required String initial,
      bool isHighlighted = false,
    }) {
      final currencyFormatter = NumberFormat.currency(
        locale: 'en_IN',
        symbol: '₹',
        decimalDigits: 2,
      );

      final dateTimeFormatter = DateFormat('dd/MM/yyyy HH:mm:ss',);

      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.width(16), // Dynamic horizontal margin
          vertical: ScreenUtilHelper.height(8),   // Dynamic vertical margin
        ),
        decoration: isHighlighted
            ? BoxDecoration(borderRadius: AppDecorations.smallRadius)
            : null,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtilHelper.height(8),   // Dynamic vertical padding
            horizontal: ScreenUtilHelper.width(16), // Dynamic horizontal padding
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: ScreenUtilHelper.width(30),  // Dynamic radius
                backgroundColor: AppColors.paymentLeadingBg,
                child: Text(
                  initial,
                  style: AppStyles.headingLargeEmphasis.copyWith(
                    color: AppColors.white,
                    fontSize: ScreenUtilHelper.fontSize(18), // Dynamic font size
                  ),
                ),
              ),
              SizedBox(width: ScreenUtilHelper.width(16)), // Dynamic width
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: AppStyles.headingLargeEmphasis.copyWith(
                              color: AppColors.black,
                              fontSize: ScreenUtilHelper.fontSize(18), // Dynamic font size
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: ScreenUtilHelper.width(8)), // Dynamic width
                        Text(
                          currencyFormatter.format(amount),
                          style: AppStyles.headingLargeEmphasis.copyWith(
                            color: AppColors.black,
                            fontSize: ScreenUtilHelper.fontSize(18), // Dynamic font size
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtilHelper.height(4)),  // Dynamic height
                    Text(
                      dateTimeFormatter.format(dateTime),
                      style: AppStyles.bodySmallEmphasis.copyWith(
                        color: AppColors.ash,
                        fontSize: ScreenUtilHelper.fontSize(14), // Dynamic font size
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(2)),  // Dynamic height
                    Text(
                      status,
                      style: AppStyles.bodySmallEmphasis.copyWith(
                        color: AppColors.ash,
                        fontSize: ScreenUtilHelper.fontSize(14), // Dynamic font size
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: Padding(
          padding: EdgeInsets.only(left: ScreenUtilHelper.width(16)), // Dynamic left padding
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              final router = GoRouter.of(context);
              if (router.canPop()) {
                router.pop();
              } else {
                router.go('/student'); // or whatever your dashboard route is
              }
            },
          ),
        ),
        title: Text(
          "Transaction Status",
          style: AppStyles.display.copyWith(
            fontSize: ScreenUtilHelper.fontSize(20), // Dynamic font size
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: transactionData.length,
        itemBuilder: (context, index) {
          final item = transactionData[index];
          return Column(
            children: [
              buildTransactionItem(
                name: item['name'] as String,
                dateTime: item['dateTime'] as DateTime,
                status: item['status'] as String,
                amount: item['amount'] as double,
                initial: item['initial'] as String,
                isHighlighted: item['isHighlighted'] as bool,
              ),
              Divider(
                color: AppColors.ash,
                height: ScreenUtilHelper.height(4),  // Dynamic height
                indent: ScreenUtilHelper.width(16),  // Dynamic indent
                endIndent: ScreenUtilHelper.width(16), // Dynamic endIndent
              ),
            ],
          );
        },
      ),
    );
  }
}
