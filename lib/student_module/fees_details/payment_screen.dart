import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/app_decorations.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_styles.dart';
import '../../core/utils/screen_util_helper.dart';
import 'bloc/payment_bloc.dart';

class PaymentPage extends StatelessWidget {
  final String amount;
  const PaymentPage({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentBloc(),
      child: PaymentView(amount: amount),
    );
  }
}

class PaymentView extends StatefulWidget {
  final String amount;
  const PaymentView({super.key, required this.amount});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            final router = GoRouter.of(context);
            if (router.canPop()) {
              router.pop();
            } else {
              router.go('/student');
            }
          },
        ),
        title: Text(
          'Payment',
          style: AppStyles.display.copyWith(
            fontSize: ScreenUtilHelper.fontSize(20),
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: BlocListener<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is PaymentFailure) {
            _showPaymentFailedDialog(context, state.error);
          } else if (state is PaymentSuccess) {
            showPaymentSuccessSheet(context, state.details);
          }
        },
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(20),
            vertical: ScreenUtilHelper.height(16),
          ),
          children: [
            _buildPaymentSectionHeader(
              context: context,
              icon: Icons.credit_card,
              title: 'Credit / Debit / ATM Card',
              subtitle: 'Add and secure cards as per RBI guidelines',
              isInitiallyExpanded: true,
              children: [
                _buildCardTile(context, 'card_3320',
                    CircleAvatar(backgroundColor: Colors.orange, radius: 12),
                    '**** **** **** 3320', widget.amount),
                _buildCardTile(
                    context,
                    'card_8067',
                    const Text(
                      "VISA",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                    '**** **** **** 8067',
                    widget.amount),
              ],
            ),
            SizedBox(height: ScreenUtilHelper.height(16)),
            _buildPaymentSectionHeader(
              context: context,
              icon: Icons.account_balance,
              title: 'Net Banking',
              subtitle: 'Select your bank',
              children: [],
            ),
            //SizedBox(height: ScreenUtilHelper.height(8)),
            _buildPaymentSectionHeader(
              context: context,
              icon: Icons.qr_code_scanner,
              title: 'UPI',
              subtitle: 'Pay directly from your bank account',
              children: [],
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentFailedDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: AppDecorations.normalRadius),
          contentPadding: EdgeInsets.all(ScreenUtilHelper.width(24)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                  radius: 35,
                  backgroundColor: AppColors.error,
                  child: const Icon(Icons.close,
                      color: AppColors.white, size: 40)),
              SizedBox(height: ScreenUtilHelper.height(16)),
              Text('Payment Unsuccessful',
                  textAlign: TextAlign.center,
                  style: AppStyles.headingLarge
                      .copyWith(color: AppColors.blackHighEmphasis)),
              SizedBox(height: ScreenUtilHelper.height(8)),
              Text(message,
                  textAlign: TextAlign.center,
                  style: AppStyles.bodySmall.copyWith(color: AppColors.stone)),
              SizedBox(height: ScreenUtilHelper.height(24)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  minimumSize:
                  Size(double.infinity, ScreenUtilHelper.height(48)),
                  shape: RoundedRectangleBorder(
                      borderRadius: AppDecorations.normalRadius),
                ),
                child: const Text('Try Again'),
                onPressed: () {
                  GoRouter.of(dialogContext).pop();
                  context.read<PaymentBloc>().add(NavigateHome());
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showPaymentSuccessSheet(BuildContext context, TransactionDetails details) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final timeFormat = DateFormat('HH:mm:ss');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (sheetContext) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = MediaQuery.of(context).size.height;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.06, vertical: height * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Payment Successful',
                      style: AppStyles.display
                          .copyWith(fontSize: width * 0.06)),
                  SizedBox(height: height * 0.03),
                  Icon(Icons.check_circle,
                      color: AppColors.success, size: width * 0.18),
                  SizedBox(height: height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Paid',
                                style: AppStyles.bodyEmphasis
                                    .copyWith(color: AppColors.black)),
                            const SizedBox(height: 5),
                            Text(
                                '${dateFormat.format(details.timestamp)}   ${timeFormat.format(details.timestamp)}',
                                style: AppStyles.bodySmall
                                    .copyWith(color: AppColors.black)),
                          ]),
                      Text(details.amount,
                          style: AppStyles.heading
                              .copyWith(color: AppColors.black)),
                    ],
                  ),
                  SizedBox(height: height * 0.03),
                  _buildInfoBlock('Transaction Id', details.transactionId),
                  _buildInfoBlock('From', details.payerName),
                  _buildInfoBlock('Suggested Actions',
                      'Your fee payment is successful. No further action required'),
                  SizedBox(height: height * 0.04),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: height * 0.02),
                        shape: RoundedRectangleBorder(
                            borderRadius: AppDecorations.normalRadius),
                        side: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1.5),
                        foregroundColor: Theme.of(context).primaryColor,
                      ),
                      child: Text('Go to Home', style: AppStyles.bodyEmphasis),
                      onPressed: () =>
                          context.go(AppRoutes.studentDashboard),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInfoBlock(String title, String value) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(top: ScreenUtilHelper.height(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                AppStyles.bodyEmphasis.copyWith(color: AppColors.black)),
            SizedBox(height: ScreenUtilHelper.height(5)),
            Text(value,
                style: AppStyles.bold
                    .copyWith(color: AppColors.blackMediumEmphasis)),
          ],
        ),
      ),
    );
  }
}

Widget _buildPaymentSectionHeader({
  required BuildContext context,
  required IconData icon,
  required String title,
  required String subtitle,
  required List<Widget> children,
  bool isInitiallyExpanded = false,
}) {
  return Theme(
    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
    child: ExpansionTile(
      initiallyExpanded: isInitiallyExpanded,
      leading: Icon(icon, color: AppColors.blackMediumEmphasis),
      backgroundColor: AppColors.white,
      collapsedBackgroundColor: AppColors.white,
      tilePadding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.width(16),
          vertical: ScreenUtilHelper.height(8)),
      childrenPadding: EdgeInsets.only(
          bottom: ScreenUtilHelper.height(8),
          left: ScreenUtilHelper.width(16),
          right: ScreenUtilHelper.width(16)),
      title: Text(title,
          style: AppStyles.bodyBold.copyWith(color: Colors.black87)),
      subtitle:
      Text(subtitle, style: AppStyles.bold.copyWith(color: AppColors.black)),
      children: children,
    ),
  );
}

Widget _buildCardTile(
    BuildContext context,
    String cardId,
    Widget logo,
    String maskedNumber,
    String amount,
    ) {
  final bloc = context.watch<PaymentBloc>();
  final isProcessing = bloc.state is PaymentProcessing &&
      (bloc.state as PaymentProcessing).processingMethodId == cardId;

  return ListTile(
    leading: logo,
    title: Text(maskedNumber,
        style: const TextStyle(
            color: AppColors.black, letterSpacing: 1.5)),
    trailing: isProcessing
        ? const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
            strokeWidth: 2, color: AppColors.success))
        : const Icon(Icons.arrow_forward_ios,
        size: 16, color: AppColors.ash),
    onTap: isProcessing
        ? null
        : () {
      context
          .read<PaymentBloc>()
          .add(ProcessPayment(amount: amount, paymentMethodId: cardId));
    },
    contentPadding:
    EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(16)),
  );
}
