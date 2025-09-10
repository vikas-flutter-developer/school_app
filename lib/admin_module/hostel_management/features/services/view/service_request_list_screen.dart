import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../routes/app_routes.dart';
import '../../../models/service_request_model.dart';
import '../bloc/services_bloc.dart';
import '../bloc/services_event.dart';
import '../bloc/services_state.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class ServiceRequestListsScreen extends StatefulWidget {
  const ServiceRequestListsScreen({super.key});

  @override
  State<ServiceRequestListsScreen> createState() => _ServiceRequestListsScreenState();
}

class _ServiceRequestListsScreenState extends State<ServiceRequestListsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ServiceRequestsBloc>().add(LoadServiceRequests());
  }

  String _getStatusText(RequestStatus status) {
    switch (status) {
      case RequestStatus.pending:
        return 'Pending';
      case RequestStatus.approved:
        return 'Approved';
      case RequestStatus.resolved:
        return 'Resolved';
      case RequestStatus.completed:
        return 'Completed';
      case RequestStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color _getStatusColor(RequestStatus status, ThemeData theme) {
    switch (status) {
      case RequestStatus.pending:
        return AppColors.pending;
      case RequestStatus.approved:
        return AppColors.success;
      case RequestStatus.resolved:
        return AppColors.info;
      case RequestStatus.completed:
        return theme.primaryColor;
      case RequestStatus.cancelled:
        return theme.colorScheme.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/edudibon_logo.png',
          width: ScreenUtilHelper.width(100),
          height: ScreenUtilHelper.height(50),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: theme.primaryColor, size: ScreenUtilHelper.scaleAll(24)),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<ServiceRequestsBloc, ServiceRequestState>(
        listener: (context, state) {
          if (state is ServiceRequestError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is ServiceRequestUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is ServiceRequestLoading && state is! ServiceRequestListLoadSuccess) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ServiceRequestListLoadSuccess) {
            if (state.requests.isEmpty) {
              return const Center(child: Text('No service requests found.'));
            }
            return ListView.builder(
              padding: EdgeInsets.all(ScreenUtilHelper.width(12.0)),
              itemCount: state.requests.length,
              itemBuilder: (context, index) {
                final request = state.requests[index];
                return _ServiceRequestCard(
                  request: request,
                  statusText: _getStatusText(request.status),
                  statusColor: _getStatusColor(request.status, theme),
                  onTakeAction: request.status == RequestStatus.approved
                      ? () {
                    context.read<ServiceRequestsBloc>().add(UpdateServiceRequestStatus(
                        request.id,
                        RequestStatus.resolved,
                        actionComment: "Contacted MSEB"));
                  }
                      : null,
                );
              },
            );
          }
          return const Center(child: Text('Loading service requests...'));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.hostelServiceRequestForm),
        label: Text('Create', style: AppStyles.bodySmall.copyWith(color: AppColors.white)),
        icon: Icon(Icons.add, size: ScreenUtilHelper.scaleAll(20),color: AppColors.white),
        backgroundColor: theme.primaryColor,
      ),
    );
  }
}

class _ServiceRequestCard extends StatelessWidget {
  final ServiceRequestItems request;
  final String statusText;
  final Color statusColor;
  final VoidCallback? onTakeAction;

  const _ServiceRequestCard({
    required this.request,
    required this.statusText,
    required this.statusColor,
    this.onTakeAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    return Card(
      margin: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8.0)),
      color: theme.colorScheme.surface.withOpacity(0.9),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Request ID ${request.id.replaceAll("sr", "2025 2536 ")}',
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.primaryColor),
                ),
                Text(
                  statusText,
                  style: theme.textTheme.labelSmall?.copyWith(color: statusColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(dateFormat.format(request.date), style: theme.textTheme.bodySmall),
            SizedBox(height: ScreenUtilHelper.height(8)),
            _buildDetailRow('Product', request.productName ?? 'N/A', theme),
            _buildDetailRow('Quantity', request.quantity?.toString() ?? 'N/A', theme),
            _buildDetailRow('Service', request.serviceType ?? 'N/A', theme),
            _buildDetailRow('Priority', request.priority.name.toUpperCase(), theme),
            if (request.comment != null && request.comment!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: ScreenUtilHelper.height(8.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Comment:', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                    Text(request.comment!, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
            if (request.status == RequestStatus.approved && request.actionComment == null)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onTakeAction,
                  child: Text('Take Action', style: TextStyle(color: theme.primaryColor)),
                ),
              ),
            if (request.status == RequestStatus.approved && request.actionComment != null)
              Padding(
                padding: EdgeInsets.only(top: ScreenUtilHelper.height(8.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Status: Resolved', style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.info, fontWeight: FontWeight.w500)),
                    Text('Action: ${request.actionComment}', style: theme.textTheme.bodyMedium),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(2.0)),
      child: Row(
        children: [
          SizedBox(
            width: ScreenUtilHelper.width(80),
            child: Text('$label:', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
          ),
          Expanded(child: Text(value, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
