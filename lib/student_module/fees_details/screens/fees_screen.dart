import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';

import '../fee_due_screens.dart';
import '../transaction_status.dart';


class FeeScreen extends StatefulWidget {
  const FeeScreen({super.key});

  @override
  State<FeeScreen> createState() => _FeeScreenState();
}

class _FeeScreenState extends State<FeeScreen> {
  final CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    final double horizontalPadding = screenWidth * 0.04;
    final double verticalSpacing = screenHeight * 0.02;
    final double iconSize = screenWidth * 0.07;
    final double titleFontSize = screenWidth * 0.05;

    // Mock data
    final List<Map<String, String>> fees = [
      {
        "date": "1",
        "month": "April",
        "year": "2024",
        "amount": "₹ 25,000.00",
        "term": "Term I",
        "paidOn": "21-05-2024",
        "method": "UPI"
      },
      {
        "date": "1",
        "month": "April",
        "year": "2024",
        "amount": "₹ 25,000.00",
        "term": "Term II",
        "paidOn": "21-05-2024",
        "method": "UPI"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: horizontalPadding),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              final router = GoRouter.of(context);
              if (router.canPop()) {
                router.pop();
              } else {
                router.go('/student'); // dashboard route
              }
            },
          ),
        ),
        title: Text(
          'Fees',
          style: TextStyle(fontSize: titleFontSize, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, size: iconSize, color: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Notifications Clicked!")),
              );
            },
          ),
          // Icon(Icons.notifications_none, size: iconSize, color: Colors.black,
          //
          // ),
          CustomPopupMenu(
            controller: _controller,
            showArrow: true,
            arrowColor: Colors.white,
            verticalMargin: -10,
            pressType: PressType.singleClick,
            menuBuilder: () => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.white,
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Fees Dues Item
                      GestureDetector(
                        onTap: () {
                          _controller.hideMenu();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FeesDueScreen()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: const Text("Fees Dues",
                              style: TextStyle(fontSize: 15)),
                        ),
                      ),
                      // Transaction Status Item
                      GestureDetector(
                        onTap: () {
                          _controller.hideMenu();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const TransactionStatusScreen()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: const Text(" Transaction status",
                              style: TextStyle(fontSize: 15)),
                        ),
                      ),
                      // Help Item
                      GestureDetector(
                        onTap: () {
                          _controller.hideMenu();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Help Clicked")),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: const Text("Help",
                              style: TextStyle(fontSize: 15)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            child: Icon(Icons.more_vert, size: iconSize, color: Colors.black),
          ),
          SizedBox(width: horizontalPadding),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalSpacing,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Naveen Naveen",
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: verticalSpacing),
            ...fees.map(
                  (fee) => Padding(
                padding: EdgeInsets.only(bottom: verticalSpacing),
                child: FeeCardWidget(fee: fee),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeeCardWidget extends StatelessWidget {
  final Map<String, String> fee;
  const FeeCardWidget({super.key, required this.fee});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double cardHeight = screenSize.height * 0.13;

    return Container(
      height: cardHeight,
      decoration: BoxDecoration(
        color: AppColors.primaryLightest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: screenSize.width * 0.18,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  fee["date"]!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  fee["month"]!,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  fee["year"]!,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        fee["amount"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryMedium,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        child: const Text(
                          "Receipt",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  //const SizedBox(height: 2),
                  Text(
                    fee["term"]!,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Paid on: ${fee["paidOn"]!}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "Payment method: ${fee["method"]!}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}