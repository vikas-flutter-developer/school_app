import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../../../routes/app_routes.dart';
import '../../../models/visitor_pass_model.dart';
import '../bloc/visitor_bloc.dart';

class VisitorListScreen extends StatefulWidget {
  const VisitorListScreen({super.key});

  @override
  State<VisitorListScreen> createState() => _VisitorListScreenState();
}

class _VisitorListScreenState extends State<VisitorListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<VisitorBloc>().add(LoadVisitorList());
  }

  String _getStatusText(VisitorStatus status) {
    switch (status) {
      case VisitorStatus.newRequest:
        return 'New';
      case VisitorStatus.pending:
        return 'Pending';
      case VisitorStatus.approved:
        return 'Approved';
      case VisitorStatus.denied:
        return 'Denied';
    }
  }

  Color _getStatusColor(VisitorStatus status, ThemeData theme) {
    switch (status) {
      case VisitorStatus.newRequest:
        return AppColors.info;
      case VisitorStatus.pending:
        return AppColors.pending;
      case VisitorStatus.approved:
        return AppColors.success;
      case VisitorStatus.denied:
        return theme.colorScheme.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.primaryColor),
          onPressed: () => context.pop(),
        ),
        title: Image.asset(
          'assets/images/edudibon_logo.png',
          width: ScreenUtilHelper.width(100),
          height: ScreenUtilHelper.height(50),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: theme.primaryColor,
              size: ScreenUtilHelper.scaleAll(24),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: theme.primaryColor,
              size: ScreenUtilHelper.scaleAll(24),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.menu,
              color: theme.primaryColor,
              size: ScreenUtilHelper.scaleAll(24),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<VisitorBloc, VisitorState>(
        listener: (context, state) {
          if (state is VisitorError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is VisitorActionSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is VisitorLoading && state is! VisitorListLoadSuccess) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is VisitorListLoadSuccess) {
            if (state.visitorPasses.isEmpty) {
              return const Center(child: Text('No visitor passes found.'));
            }
            return Column(
              children: [
                buildSearchBar(context),
                SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.width(16.0),
                    vertical: ScreenUtilHelper.height(0),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        /* Maybe acts as a refresh or just a title */
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.primaryLightest,
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtilHelper.width(15),
                          vertical: ScreenUtilHelper.height(10),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),),
                      ),
                      child: Center(
                        child: Text(
                          "Visitor's Management",
                          style: AppStyles.headingRegular.copyWith(color: AppColors.primaryMedium),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtilHelper.height(10)),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(ScreenUtilHelper.width(12.0)),
                    itemCount: state.visitorPasses.length,
                    itemBuilder: (context, index) {
                      final pass = state.visitorPasses[index];
                      return _VisitorPassCard(
                        pass: pass,
                        statusText: _getStatusText(pass.status),
                        statusColor: _getStatusColor(pass.status, theme),
                        onApprove:
                            pass.status == VisitorStatus.newRequest
                                ? () => context.read<VisitorBloc>().add(
                                  ApproveVisitorPass(pass.id),
                                )
                                : null,
                        onDeny:
                            pass.status == VisitorStatus.newRequest
                                ? () => context.read<VisitorBloc>().add(
                                  DenyVisitorPass(pass.id),
                                )
                                : null,
                        onMoreTap:
                            pass.status != VisitorStatus.newRequest
                                ? () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "More details (not implemented)",
                                      ),
                                    ),
                                  );
                                }
                                : null,
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('Tap to load visitor passes.'));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.hostelVisitorForm),
        label: Text(
          'Create',
          style: AppStyles.body.copyWith(color: AppColors.white),
        ),
        icon: Icon(
          Icons.add,
          size: ScreenUtilHelper.scaleAll(24),
          color: AppColors.white,
        ),
        backgroundColor: AppColors.primaryMedium,
      ),
    );
  }
}

class _VisitorPassCard extends StatelessWidget {
  final VisitorPass pass;
  final String statusText;
  final Color statusColor;
  final VoidCallback? onApprove;
  final VoidCallback? onDeny;
  final VoidCallback? onMoreTap;

  const _VisitorPassCard({
    required this.pass,
    required this.statusText,
    required this.statusColor,
    this.onApprove,
    this.onDeny,
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    return Card(
      margin: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8.0)),
      color: AppColors.primaryLightest,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Visitor Pass ${pass.id.replaceAll("vp", "2025 2536 ")}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.primaryColor,
                  ),
                ),
                Text(
                  statusText,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              dateFormat.format(pass.date),
              style: theme.textTheme.bodySmall,
            ),
            SizedBox(height: ScreenUtilHelper.height(8)),
            _buildDetailRow('Name', pass.visitorName, theme, context),
            _buildDetailRow('Student', pass.studentName, theme, context),
            if (pass.status == VisitorStatus.newRequest) ...[
              _buildDetailRow('Class', pass.studentClass, theme, context),
              _buildDetailRow('Relation', pass.relation, theme, context),
            ],
            _buildDetailRow('Purpose', pass.purpose, theme, context),
            if (pass.status == VisitorStatus.newRequest) ...[
              _buildDetailRow(
                'Visit number',
                pass.visitNumber.toString(),
                theme,
                context,
              ),
              _buildDetailRow('In Time', pass.inTime ?? 'N/A', theme, context),
              _buildDetailRow(
                'Out Time',
                pass.outTime ?? 'N/A',
                theme,
                context,
              ),
              _buildDetailRow(
                'Reason',
                pass.reasonForVisit ?? 'N/A',
                theme,
                context,
              ),
            ],
            SizedBox(height: ScreenUtilHelper.height(10)),
            if (onApprove != null && onDeny != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: onDeny,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.colorScheme.error,
                      side: BorderSide(color: theme.colorScheme.error),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),),
                    ),
                    child: const Text('Denial'),
                  ),
                  SizedBox(width: ScreenUtilHelper.width(20)),
                  ElevatedButton(
                    onPressed: onApprove,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.primaryMedium,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),),
                    ),
                    child: const Text('Approve'),
                  ),
                ],
              )
            else if (onMoreTap != null)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onMoreTap,
                  child: Text(
                    'More',
                    style: TextStyle(color: theme.primaryColor),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    ThemeData theme,
    BuildContext context,
  ) {
    ScreenUtilHelper.init(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(2.0)),
      child: Row(
        children: [
          SizedBox(
            width: ScreenUtilHelper.width(100),
            child: Text(
              '$label:',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(child: Text(value, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}

Widget buildSearchBar(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: Container(
          height: ScreenUtilHelper.scaleHeight(40),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleAll(8.0)),
            border: Border.all(color: AppColors.silver, width: 1.0),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search by name, room',
              hintStyle: AppStyles.bodySmall.copyWith(color: AppColors.silver),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.ash,
                size: ScreenUtilHelper.scaleAll(22),
              ),
              suffixIcon: Icon(
                Icons.mic,
                color: AppColors.ash,
                size: ScreenUtilHelper.scaleAll(22),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: ScreenUtilHelper.scaleHeight(11),
              ),
            ),
          ),
        ),
      ),
      SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
      Container(
        height: ScreenUtilHelper.scaleHeight(40),
        width: ScreenUtilHelper.scaleWidth(40),
        decoration: BoxDecoration(
          color: AppColors.bluishLightBackgroundshilu,
          borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleAll(9)),
        ),
        child: const Icon(
          Icons.filter_list,
          size: 22,
          color: AppColors.primary,
        ),
      ),
    ],
  );
}
