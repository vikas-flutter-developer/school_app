import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../student_module/fees_details/bloc/fees_bloc.dart';

// import '../bloc/fee_bloc.dart';

class FeeCardWidget extends StatelessWidget {
  final Fee fee;

  const FeeCardWidget({super.key, required this.fee});

  @override
  Widget build(BuildContext context) {
    // Extract day and month for the card's visual
    String? day, month;
    if (fee.date.isNotEmpty && fee.date != 'N/A') {
      try {
        final dateParts = fee.date.split('-');
        if (dateParts.length >= 3) {
          day = dateParts[2];
          month = _getMonthName(int.tryParse(dateParts[1]));
        }
      } catch (e) {
        debugPrint("Error parsing date: $e");
      }
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(237, 236, 248, 1),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 90.0,
            height: 160.0,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(146, 143, 211, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day ?? '',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  month ?? '',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  fee.date.isNotEmpty && fee.date != 'N/A'
                      ? fee.date.split('-')[0]
                      : '',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        fee.amount,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _showRequestSentBottomSheet(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text('Receipt'),
                      ),
                    ],
                  ),
                  Text(
                    fee.term,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Paid on : ${fee.date}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    'Status: ${fee.paymentStatus}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRequestSentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          width: 430,
          height: 459,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
              const SizedBox(
                width: 333,
                height: 33,
                child: Center(
                  child: Text(
                    'Your receipt is being generated',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Open Sand',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const SizedBox(height: 50),
              SizedBox(
                width: 338,
                height: 49,
                child: TextButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      side: const BorderSide(color: Colors.indigo, width: 1.0),
                    ),
                  ),
                  child: const Text("View Receipt"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getMonthName(int? month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }
}
