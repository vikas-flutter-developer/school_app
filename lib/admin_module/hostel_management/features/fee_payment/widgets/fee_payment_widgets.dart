import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../models/financial_item_model.dart';

class FinancialSection extends StatelessWidget {
  final String title;
  final String totalAmount;
  final List<FinancialItemData> items;

  const FinancialSection({
    super.key,
    required this.title,
    required this.totalAmount,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(9.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppStyles.body.copyWith(color: AppColors.secondaryContrast),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                label: const Text(
                  "Report",
                  style: TextStyle(color: AppColors.black),
                ),
                icon: Icon(
                  Icons.download_outlined,
                  size: ScreenUtilHelper.scaleAll(18),
                  color: AppColors.jet,
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.success),
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.width(12),
                    vertical: ScreenUtilHelper.height(6),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
                  ),
                ),
              ),
            ],
          ),
          Text(
            totalAmount,
            style: AppStyles.headingLargeEmphasis.copyWith(color: AppColors.blackHighEmphasis),
          ),
          SizedBox(height: ScreenUtilHelper.height(16)),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: ScreenUtilHelper.width(12.0),
              mainAxisSpacing: ScreenUtilHelper.height(12.0),
              childAspectRatio: 1.8,
            ),
            itemBuilder: (context, index) {
              return _FinancialItemCard(item: items[index]);
            },
          ),
        ],
      ),
    );
  }
}

class _FinancialItemCard extends StatelessWidget {
  final FinancialItemData item;
  const _FinancialItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(15.0)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.amount,
              style: AppStyles.display.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.black),
            ),
            SizedBox(height: ScreenUtilHelper.height(4)),
            Text(
              item.label,
              style: TextStyle(
                fontSize: AppStyles.size.tinyPlus,
                color: AppColors.stone,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}