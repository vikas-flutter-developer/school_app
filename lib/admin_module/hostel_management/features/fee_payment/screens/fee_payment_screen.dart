import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../bloc/fee_payment_bloc.dart';
import '../models/financial_item_model.dart';
import '../widgets/fee_payment_widgets.dart';

class FeePaymentscreen extends StatelessWidget {
  const FeePaymentscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeePaymentBloc()..add(FeePaymentInitialEvent()),
      child: const _FeePaymentscreenView(),
    );
  }
}

class _FeePaymentscreenView extends StatelessWidget {
  const _FeePaymentscreenView();

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.blackMediumEmphasis,
            size: ScreenUtilHelper.scaleAll(20),
          ),
          onPressed: ()=> GoRouter.of(context).pop(),
        ),
        title: SizedBox(
          width: ScreenUtilHelper.width(159),
          height: ScreenUtilHelper.height(39),
          child: Image.asset("assets/images/edudibon.png"),
        ),
        centerTitle: false,
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications_none_outlined,
                  color: AppColors.blackMediumEmphasis,
                  size: ScreenUtilHelper.scaleAll(28),
                ),
                onPressed: () {},
              ),
              Positioned(
                right: ScreenUtilHelper.width(8),
                top: ScreenUtilHelper.height(8),
                child: Container(
                  padding: EdgeInsets.all(ScreenUtilHelper.width(2)),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius:
                    BorderRadius.circular(ScreenUtilHelper.radius(8)),
                  ),
                  constraints: BoxConstraints(
                    minWidth: ScreenUtilHelper.width(16),
                    minHeight: ScreenUtilHelper.height(16),
                  ),
                  child: Text(
                    '3',
                    style: AppStyles.badge1.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: ScreenUtilHelper.width(8)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(16),
                  vertical: ScreenUtilHelper.height(10)),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      height: ScreenUtilHelper.height(40),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search by name, room',
                          hintStyle: TextStyle(
                            color: AppColors.silver,
                            fontSize: ScreenUtilHelper.fontSize(15),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.cloud,
                            size: ScreenUtilHelper.scaleAll(22),
                          ),
                          suffixIcon: Icon(
                            Icons.mic,
                            color: AppColors.slate,
                            size: ScreenUtilHelper.scaleAll(22),
                          ),
                          filled: true,
                          fillColor: AppColors.transparent,
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                ScreenUtilHelper.radius(12.0)),
                            borderSide:
                             BorderSide(color: AppColors.slate),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                ScreenUtilHelper.radius(12.0)),
                            borderSide:
                             BorderSide(color: AppColors.slate),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                ScreenUtilHelper.radius(12.0)),
                            borderSide:
                             BorderSide(color: AppColors.slate),
                          ),

                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenUtilHelper.width(8)),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: ScreenUtilHelper.height(38),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(ScreenUtilHelper.radius(9)),
                        border: Border.all(
                          color: AppColors.accentLight,
                          width: ScreenUtilHelper.width(1.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.tune,
                              size: ScreenUtilHelper.scaleAll(20),
                              color: AppColors.secondaryContrast,
                            ),
                          ),
                          SizedBox(width: ScreenUtilHelper.width(5)),
                          Icon(
                            Icons.sort,
                            size: ScreenUtilHelper.scaleAll(20),
                            color: AppColors.secondaryContrast,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(16.0),
                vertical: ScreenUtilHelper.height(10.0),
              ),
              child: Column(
                children: [
                  SizedBox(height: ScreenUtilHelper.height(10)),
                  FinancialSection(
                    title: "Students Fees",
                    totalAmount: "4,45,789",
                    items: [
                      FinancialItemData("8,45,789", "Advance"),
                      FinancialItemData("6,23,734", "Pending"),
                      FinancialItemData("1,45,789", "Caution Money"),
                      FinancialItemData("65,234", "Penalty Charges"),
                    ],
                  ),
                  SizedBox(height: ScreenUtilHelper.height(20)),
                  FinancialSection(
                    title: "Management Payments",
                    totalAmount: "4,45,789",
                    items: [
                      FinancialItemData("1,45,789", "Staff Payment"),
                      FinancialItemData("45,789", "Services"),
                      FinancialItemData("5,789", "Emergency"),
                      FinancialItemData("1789", "Miscellaneous"),
                    ],
                  ),
                  SizedBox(height: ScreenUtilHelper.height(20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}