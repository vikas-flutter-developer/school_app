import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../../../core/utils/app_colors.dart';
import '../bloc/po_management/po_management_bloc.dart';
import '../widgets/error_display.dart';
import '../widgets/loading_indicator.dart';
import '../data/models/bill_model.dart';
import '../data/models/purchase_order_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/pagination_controls.dart';

class PoManagementScreen extends StatefulWidget {
  const PoManagementScreen({super.key});
  static const routeName = '/po-management';

  @override
  State<PoManagementScreen> createState() => _PoManagementScreenState();
}

class _PoManagementScreenState extends State<PoManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _poCurrentPage = 1;
  final int _poItemsPerPage = 10;
  int _billCurrentPage = 1;
  final int _billItemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    final poBloc = context.read<PoManagementBloc>();
    if (poBloc.state.poListStatus != PoManagementStatus.success &&
        poBloc.state.poListStatus != PoManagementStatus.loading) {
      poBloc.add(LoadPurchaseOrders());
    }
    if (poBloc.state.billListStatus != PoManagementStatus.success &&
        poBloc.state.billListStatus != PoManagementStatus.loading) {
      poBloc.add(LoadBills());
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✨ Responsive change: Initialize the helper
    ScreenUtilHelper.init(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.linen,
      appBar: CustomAppBar(
        showAddAction: true,
        addActionText: 'Add Purchase Order',
        onAddActionPressed: () {
          context.read<PoManagementBloc>().add(ResetPoForm());
          context.push(AppRoutes.addPurchaseOrder);
          },
        logoAssetPath: 'assets/images/edudibon_logo.png',
        pageTitle: 'PO Management',
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.ash.withOpacity(0.1),
                  // ✨ Responsive change
                  spreadRadius: ScreenUtilHelper.scaleAll(1),
                  blurRadius: ScreenUtilHelper.scaleAll(3),
                  offset: Offset(0, ScreenUtilHelper.height(2)),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.secondaryDarker,
              unselectedLabelColor: AppColors.ash,
              indicatorColor: AppColors.secondaryDarker,
              // ✨ Responsive change
              indicatorWeight: ScreenUtilHelper.height(3.0),
              labelStyle: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtilHelper.fontSize(14),
              ),
              unselectedLabelStyle: theme.textTheme.titleSmall
                  ?.copyWith(fontSize: ScreenUtilHelper.fontSize(14)),
              tabs: const [
                Tab(text: 'Create'),
                Tab(text: 'Bills'),
              ],
            ),
          ),
          Expanded(
            child: BlocConsumer<PoManagementBloc, PoManagementState>(
              listener: (context, state) {
                if (state.poListStatus == PoManagementStatus.failure && _tabController.index == 0) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(state.poListErrorMessage ?? 'Failed to load purchase orders.'),
                        backgroundColor: AppColors.error,
                      ),
                    );
                }
                if (state.billListStatus == PoManagementStatus.failure && _tabController.index == 1) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(state.billListErrorMessage ?? 'Failed to load bills.'),
                        backgroundColor: AppColors.error,
                      ),
                    );
                }
              },
              builder: (context, state) {
                return TabBarView(
                  controller: _tabController,
                  children: [
                    _buildPurchaseOrderList(context, state),
                    _buildBillList(context, state),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Padding(
        // ✨ Responsive change
        padding: EdgeInsets.all(ScreenUtilHelper.width(20.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              // ✨ Responsive change
              size: ScreenUtilHelper.scaleAll(60),
              color: AppColors.ash.withOpacity(0.5),
            ),
            // ✨ Responsive change
            SizedBox(height: ScreenUtilHelper.height(16)),
            Text(
              message,
              textAlign: TextAlign.center,
              // ✨ Responsive change
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.ash,
                fontSize: ScreenUtilHelper.fontSize(16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchaseOrderList(
      BuildContext context,
      PoManagementState state,
      ) {
    if (state.poListStatus == PoManagementStatus.loading && state.purchaseOrders.isEmpty) {
      return const LoadingIndicator();
    }
    if (state.poListStatus == PoManagementStatus.failure && state.purchaseOrders.isEmpty) {
      return ErrorDisplay(
        message: state.poListErrorMessage ?? 'Failed to load purchase orders.',
        onRetry: () => context.read<PoManagementBloc>().add(LoadPurchaseOrders()),
      );
    }
    if (state.purchaseOrders.isEmpty) {
      return _buildEmptyState('No purchase orders found.');
    }

    final paginatedPOs = state.purchaseOrders
        .skip((_poCurrentPage - 1) * _poItemsPerPage)
        .take(_poItemsPerPage)
        .toList();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(ScreenUtilHelper.width(8.0)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  // ✨ Responsive changes
                  columnSpacing: ScreenUtilHelper.width(16),
                  headingRowHeight: ScreenUtilHelper.height(48),
                  dataRowMinHeight: ScreenUtilHelper.height(48),
                  dataRowMaxHeight: ScreenUtilHelper.height(56),
                  headingTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackHighEmphasis,
                    fontSize: ScreenUtilHelper.fontSize(14),
                  ),
                  columns: const [
                    DataColumn(label: Text('P.O No.')),
                    DataColumn(label: Text('Created No')),
                    DataColumn(label: Text('Vendor Name')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Amount')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: paginatedPOs.map((po) {
                    return DataRow(
                      cells: [
                        DataCell(Text(po.poNumber, style: TextStyle(fontSize: ScreenUtilHelper.fontSize(13)))),
                        DataCell(Text(po.createdNumber, style: TextStyle(fontSize: ScreenUtilHelper.fontSize(13)))),
                        DataCell(Text(po.vendorName, style: TextStyle(fontSize: ScreenUtilHelper.fontSize(13)))),
                        DataCell(
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtilHelper.width(8),
                              vertical: ScreenUtilHelper.height(4),
                            ),
                            decoration: BoxDecoration(
                              color: _getPOStatusColor(po.status).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12)),
                            ),
                            child: Text(
                              _poStatusToString(po.status),
                              style: TextStyle(
                                color: _getPOStatusColor(po.status),
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtilHelper.fontSize(12),
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            NumberFormat.currency(symbol: '₹', decimalDigits: 2).format(po.amount),
                            style: TextStyle(fontSize: ScreenUtilHelper.fontSize(13)),
                          ),
                        ),
                        DataCell(
                          PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert, color: AppColors.ash, size: ScreenUtilHelper.scaleAll(22)),
                            itemBuilder: (context) => [
                              PopupMenuItem(value: 'view', child: Text('View Details', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)))),
                              PopupMenuItem(value: 'edit', child: Text('Edit PO', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)))),
                              if (po.status == POStatus.pending || po.status == POStatus.approved)
                                PopupMenuItem(
                                  value: 'cancel',
                                  child: Text('Cancel PO', style: TextStyle(color: AppColors.error, fontSize: ScreenUtilHelper.fontSize(14))),
                                ),
                            ],
                            onSelected: (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Action: $value for ${po.poNumber}')),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
        if (state.purchaseOrders.length > _poItemsPerPage)
          PaginationControls(
            currentPage: _poCurrentPage,
            totalPages: (state.purchaseOrders.length / _poItemsPerPage).ceil(),
            onPageChanged: (page) => setState(() => _poCurrentPage = page),
          ),
      ],
    );
  }

  Widget _buildBillList(BuildContext context, PoManagementState state) {
    if (state.billListStatus == PoManagementStatus.loading && state.bills.isEmpty) {
      return const LoadingIndicator();
    }
    if (state.billListStatus == PoManagementStatus.failure && state.bills.isEmpty) {
      return ErrorDisplay(
        message: state.billListErrorMessage ?? 'Failed to load bills.',
        onRetry: () => context.read<PoManagementBloc>().add(LoadBills()),
      );
    }
    if (state.bills.isEmpty) {
      return _buildEmptyState('No bills found.');
    }

    final paginatedBills = state.bills
        .skip((_billCurrentPage - 1) * _billItemsPerPage)
        .take(_billItemsPerPage)
        .toList();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(ScreenUtilHelper.width(8.0)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  // ✨ Responsive changes
                  columnSpacing: ScreenUtilHelper.width(16),
                  headingRowHeight: ScreenUtilHelper.height(48),
                  dataRowMinHeight: ScreenUtilHelper.height(48),
                  dataRowMaxHeight: ScreenUtilHelper.height(56),
                  headingTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackHighEmphasis,
                    fontSize: ScreenUtilHelper.fontSize(14),
                  ),
                  columns: const [
                    DataColumn(label: Text('Bill No.')),
                    DataColumn(label: Text('Amount')),
                    DataColumn(label: Text('Bill Date')),
                    DataColumn(label: Text('Due Date')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: paginatedBills.map((bill) {
                    return DataRow(
                      cells: [
                        DataCell(Text(bill.billNo, style: TextStyle(fontSize: ScreenUtilHelper.fontSize(13)))),
                        DataCell(
                          Text(
                            NumberFormat.currency(symbol: '₹', decimalDigits: 2).format(bill.amount),
                            style: TextStyle(fontSize: ScreenUtilHelper.fontSize(13)),
                          ),
                        ),
                        DataCell(Text(DateFormat('dd MMM, yyyy').format(bill.billDate), style: TextStyle(fontSize: ScreenUtilHelper.fontSize(13)))),
                        DataCell(Text(DateFormat('dd MMM, yyyy').format(bill.dueDate), style: TextStyle(fontSize: ScreenUtilHelper.fontSize(13)))),
                        DataCell(
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtilHelper.width(8),
                              vertical: ScreenUtilHelper.height(4),
                            ),
                            decoration: BoxDecoration(
                              color: _getBillStatusColor(bill.status).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12)),
                            ),
                            child: Text(
                              _billStatusToString(bill.status),
                              style: TextStyle(
                                color: _getBillStatusColor(bill.status),
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtilHelper.fontSize(12),
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.delete_outline, color: AppColors.error, size: ScreenUtilHelper.scaleAll(22)),
                            tooltip: 'Delete Bill',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (dialogContext) => AlertDialog(
                                  title: Text('Confirm Delete', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(18), fontWeight: FontWeight.bold)),
                                  content: Text('Are you sure you want to delete bill ${bill.billNo}?', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
                                  actions: [
                                    TextButton(
                                      onPressed: () => GoRouter.of(context).pop(),
                                      child: Text('Cancel', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Delete action for ${bill.billNo}')),
                                        );
                                        GoRouter.of(context).pop();
                                      },
                                      child: Text('Delete', style: TextStyle(color: AppColors.error, fontSize: ScreenUtilHelper.fontSize(14))),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
        if (state.bills.length > _billItemsPerPage)
          PaginationControls(
            currentPage: _billCurrentPage,
            totalPages: (state.bills.length / _billItemsPerPage).ceil(),
            onPageChanged: (page) => setState(() => _billCurrentPage = page),
          ),
      ],
    );
  }

  String _poStatusToString(POStatus status) {
    return status.toString().split('.').last.capitalize();
  }

  String _billStatusToString(BillStatus status) {
    return status.toString().split('.').last.capitalize();
  }

  Color _getPOStatusColor(POStatus status) {
    switch (status) {
      case POStatus.pending:
        return AppColors.pending;
      case POStatus.approved:
        return AppColors.infoDark;
      case POStatus.processing:
        return Colors.teal.shade600;
      case POStatus.shipped:
        return Colors.purple.shade600;
      case POStatus.delivered:
        return AppColors.success;
      case POStatus.cancelled:
        return AppColors.error;
    // ✨ Null safety fix: Add a default case to handle any unlisted enum values.
      default:
        return AppColors.ash;
    }
  }

  Color _getBillStatusColor(BillStatus status) {
    switch (status) {
      case BillStatus.pending:
        return AppColors.pending;
      case BillStatus.paid:
        return AppColors.success;
      case BillStatus.overdue:
        return AppColors.error;
    // ✨ Null safety fix: Add a default case.
      default:
        return AppColors.ash;
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}