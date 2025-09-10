import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../bloc/payroll_bloc.dart';
import '../bloc/payroll_event.dart';
import '../bloc/payroll_state.dart';

class PayrollScreen extends StatelessWidget {
  const PayrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery( // ✅ Ensures MediaQuery is present
      data: MediaQuery.of(context),
      child: Builder(builder: (context) {
        ScreenUtilHelper.init(context); // ✅ Uses MediaQuery context

        return BlocProvider(
          create: (_) => PayrollBloc()..add(LoadPayroll()),
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: AppColors.black),
                onPressed: () => GoRouter.of(context).pop(),
              ),
              title: Row(
                children: [
                  Image.asset(
                    'assets/images/edudibon_logo.png',
                    height: ScreenUtilHelper.height(24),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.notifications_none_outlined, color: AppColors.black),
                  onPressed: () {},
                ),
              ],
              elevation: 0,
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.black,
            ),
            body: BlocBuilder<PayrollBloc, PayrollState>(
              builder: (context, state) {
                if (state is PayrollLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is PayrollError) {
                  return Center(child: Text(state.message));
                }
                if (state is PayrollLoaded) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(ScreenUtilHelper.width(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Manisha Shah",
                          style: TextStyle(
                            fontSize: ScreenUtilHelper.fontSize(20),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Employee type - Permanent",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: ScreenUtilHelper.fontSize(14),
                          ),
                        ),
                        Text(
                          "PF number - 12453 66577",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: ScreenUtilHelper.fontSize(14),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...state.payrolls.map(
                              (data) => Padding(
                            padding: EdgeInsets.only(bottom: ScreenUtilHelper.height(12)),
                            child: PayrollCard(
                              monthYear: data.monthYear,
                              workingDays: data.workingDays,
                              totalCredited: data.totalCredited,
                            ),
                          ),
                        ),
                        SizedBox(height: ScreenUtilHelper.height(80)),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        );
      }),
    );
  }
}

class PayrollCard extends StatelessWidget {
  final String monthYear;
  final int workingDays;
  final String totalCredited;

  const PayrollCard({
    super.key,
    required this.monthYear,
    required this.workingDays,
    required this.totalCredited,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryMedium),
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6)),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.width(12),
              vertical: ScreenUtilHelper.height(8),
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryMedium,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ScreenUtilHelper.radius(6)),
                topRight: Radius.circular(ScreenUtilHelper.radius(6)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Manisha Shah",
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  monthYear,
                  style: const TextStyle(color: AppColors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtilHelper.width(12)),
            child: Column(
              children: [
                const RowInfo(label: "Sub - Department", value: "Primary"),
                const RowInfo(label: "Joining Date", value: "12/02/25"),
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text("Salary"),
                    ),
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "view breakdown",
                          style: TextStyle(
                            color: AppColors.primaryMedium,
                            //decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                RowInfo(label: "Working Days", value: "$workingDays"),
                RowInfo(label: "Total Credited", value: totalCredited),
                const RowInfo(label: "PF Deducted", value: "1,674/-"),
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text("Receipt"),
                    ),
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Download Here",
                          style: TextStyle(
                            color: AppColors.primaryMedium,
                            //decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RowInfo extends StatelessWidget {
  final String label;
  final String value;

  const RowInfo({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(2)),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
