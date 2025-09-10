import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../../../routes/app_routes.dart';
import '../bloc/inventory_home/inventory_home_bloc.dart';
import '../data/models/inventory_request_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_display.dart';

class InventoryHomeScreen extends StatefulWidget {
  const InventoryHomeScreen({super.key});

  static const routeName = '/inventory-home';

  @override
  State<InventoryHomeScreen> createState() => _InventoryHomeScreenState();
}

class _InventoryHomeScreenState extends State<InventoryHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InventoryHomeBloc>().add(LoadInventoryHomeData());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    return Scaffold(
      backgroundColor: AppColors.linen,
      appBar: CustomAppBar(
        showBackButton: true,
        logoAssetPath: 'assets/images/edudibon_logo.png',
        pageTitle: 'Inventory Management',
      ),
      body: BlocConsumer<InventoryHomeBloc, InventoryHomeState>(
        listener: (context, state) {
          if (state.status == InventoryHomeStatus.failure && state.errorMessage != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            
            padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildManagementCard(
                  context,
                  icon: Icons.inventory_2_outlined,
                  title: 'Inventory',
                  description: 'Lorem ipsum dolor sit amet consectetur. Pulvinar quis tristique eu lectus risus ac morbi vel..',
                  iconBgColor: AppColors.inventoryIcon,
                  iconColor: AppColors.white,
                  onTap: ()=>context.push(AppRoutes.inventory),
                ),
                
                SizedBox(height: ScreenUtilHelper.height(16)),
                _buildManagementCard(
                  context,
                  icon: Icons.local_shipping_outlined,
                  title: 'Product Order Management',
                  description: 'Lorem ipsum dolor sit amet consectetur. Pulvinar quis tristique eu lectus risus ac morbi vel..',
                  iconBgColor: AppColors.primaryBright,
                  iconColor: AppColors.white,
                  onTap: ()=>context.push(AppRoutes.poManagement),
                ),
                
                SizedBox(height: ScreenUtilHelper.height(24)),
                Text(
                  'Inventory Req for Management',
                  
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtilHelper.fontSize(20),
                  ),
                ),
                
                SizedBox(height: ScreenUtilHelper.height(16)),
                if (state.status == InventoryHomeStatus.loading && state.requests.isEmpty)
                  const LoadingIndicator(),
                if (state.status == InventoryHomeStatus.failure && state.requests.isEmpty)
                  ErrorDisplay(
                    message: state.errorMessage ?? 'Failed to load requests.',
                    onRetry: () => context.read<InventoryHomeBloc>().add(LoadInventoryHomeData()),
                  ),
                if (state.requests.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.requests.length,
                    itemBuilder: (ctx, index) {
                      final request = state.requests[index];
                      return _buildInventoryRequestCard(context, request);
                    },
                  ),
                if (state.status == InventoryHomeStatus.success && state.requests.isEmpty)
                  Center(
                    child: Text(
                      'No inventory requests found.',
                      
                      style: TextStyle(fontSize: ScreenUtilHelper.fontSize(16)),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildManagementCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String description,
        required Color iconBgColor,
        required Color iconColor,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12)),
      child: Container(
        padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12)),
          color: iconBgColor.withAlpha(24)
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(ScreenUtilHelper.width(12)),
              decoration: BoxDecoration(
                color: iconBgColor.withAlpha(180),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: ScreenUtilHelper.scaleAll(30), color: iconColor),
            ),
            
            SizedBox(width: ScreenUtilHelper.width(16)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtilHelper.fontSize(16),
                    ),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(4)),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.ash,
                      fontSize: ScreenUtilHelper.fontSize(12),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.ash,
              size: ScreenUtilHelper.scaleAll(18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInventoryRequestCard(
      BuildContext context,
      InventoryRequestModel request,
      ) {
    return Card(
      margin: EdgeInsets.only(bottom: ScreenUtilHelper.height(12)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8))),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request.className,
                    
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtilHelper.fontSize(16),
                    ),
                  ),
                  Text(
                    request.teacherName,
                    
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.ash,
                      fontSize: ScreenUtilHelper.fontSize(14),
                    ),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy').format(request.requestDate),
                    
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.ash,
                      fontSize: ScreenUtilHelper.fontSize(12),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Room No',
                  
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.ash,
                    fontSize: ScreenUtilHelper.fontSize(12),
                  ),
                ),
                Text(
                  request.roomNo,
                  
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtilHelper.fontSize(24),
                  ),
                ),
                
                SizedBox(height: ScreenUtilHelper.height(8)),
                ElevatedButton(
                  onPressed: request.status == RequestStatus.approved ? null : () {
                    _showApproveConfirmationDialog(context, request.id);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: request.status == RequestStatus.approved ? AppColors.success : AppColors.primaryMedium,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.width(20),
                      vertical: ScreenUtilHelper.height(8),
                    ),
                    textStyle: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)),
                  ),
                  child: Text(
                    request.status == RequestStatus.approved ? 'Approved' : 'Approve',
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showApproveConfirmationDialog(BuildContext context, String requestId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(15)),
          ),
          
          title: Text(
            'Are you Sure you want to ?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: ScreenUtilHelper.fontSize(18), fontWeight: FontWeight.bold),
          ),
          contentPadding: EdgeInsets.all(ScreenUtilHelper.width(20)),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            OutlinedButton(
              
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.secondaryDarker),
                foregroundColor: AppColors.secondaryDarker,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8))),
                minimumSize: Size(ScreenUtilHelper.width(100), ScreenUtilHelper.height(40)),
              ),
              onPressed: () {
                GoRouter.of(dialogContext).pop();
              },
              child: Text('Deny', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
            ),
            ElevatedButton(
              
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryDarker,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8))),
                minimumSize: Size(ScreenUtilHelper.width(100), ScreenUtilHelper.height(40)),
              ),
              onPressed: () {
                context.read<InventoryHomeBloc>().add(ApproveRequest(requestId));
                GoRouter.of(dialogContext).pop();
              },
              child: Text('Approve', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
            ),
          ],
        );
      },
    );
  }
}