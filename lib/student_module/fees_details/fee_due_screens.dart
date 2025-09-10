import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:edudibon_flutter_bloc/student_module/fees_details/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_decorations.dart';
import '../../core/utils/app_styles.dart';
import '../../core/utils/screen_util_helper.dart';

// Data Model
class FeeDueItem {
  final String receiptNo;
  final String month;
  final String paymentDate;
  final String totalPendingAmount;

  FeeDueItem({
    required this.receiptNo,
    required this.month,
    required this.paymentDate,
    required this.totalPendingAmount,
  });
}

class FeesDueScreen extends StatefulWidget {
  const FeesDueScreen({super.key});

  @override
  _FeesDueScreenState createState() => _FeesDueScreenState();
}

class _FeesDueScreenState extends State<FeesDueScreen> {
  final List<FeeDueItem> _feeDues = [
    FeeDueItem(
      receiptNo: '#98761',
      month: 'October',
      paymentDate: '10 Oct 20',
      totalPendingAmount: '₹25,000',
    ),
    FeeDueItem(
      receiptNo: '#98762',
      month: 'November',
      paymentDate: '12 Nov 20',
      totalPendingAmount: '₹10,000',
    ),
  ];

  int selectedIndex = 0; // For bottom navigation

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    final padding = ScreenUtilHelper.width(16);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
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
        title: Text(
          'Fees Dues',
          style: AppStyles.display.copyWith(fontSize: ScreenUtilHelper.fontSize(18)),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: ScreenUtilHelper.height(16)),
        itemCount: _feeDues.length,
        itemBuilder: (context, index) {
          return _buildFeeCard(context, _feeDues[index]);
        },
      ),
    );
  }

  Widget _buildFeeCard(BuildContext context, FeeDueItem item) {
    final double fontSize = ScreenUtilHelper.fontSize(14);
    final double buttonHeight = ScreenUtilHelper.height(48);

    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtilHelper.height(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDecorations.mediumRadius,
        border: Border.all(
          color: AppColors.primaryMedium,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildInfoRow('Receipt No.', item.receiptNo),
          _buildThinDivider(),
          _buildInfoRow('Month', item.month),
          _buildThinDivider(),
          _buildInfoRow('Payment Date', item.paymentDate),
          _buildThinDivider(),
          _buildInfoRow('Total Pending Amount', item.totalPendingAmount, isAmount: true),
          SizedBox(height: ScreenUtilHelper.height(16)),
          SizedBox(
            height: buttonHeight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(amount: '100'),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Processing payment for ${item.totalPendingAmount}...'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryMedium,
                foregroundColor: AppColors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                  ),
                ),
              ),
              child: Text(
                'PAY NOW',
                style: AppStyles.bodySmallEmphasis.copyWith(fontSize: fontSize),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isAmount = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtilHelper.height(12),
        horizontal: ScreenUtilHelper.width(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppStyles.bodySmall.copyWith(
              color: AppColors.ash,
              fontSize: ScreenUtilHelper.fontSize(14),
            ),
          ),
          Text(
            value,
            style: AppStyles.bodySmall.copyWith(
              color: isAmount ? AppColors.primaryDark : AppColors.black,
              fontWeight: isAmount ? FontWeight.bold : FontWeight.normal,
              fontSize: ScreenUtilHelper.fontSize(14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThinDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColors.ash,
    );
  }
}
