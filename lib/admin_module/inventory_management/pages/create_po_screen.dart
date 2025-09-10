import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/app_colors.dart';
import '../bloc/po_management/po_management_bloc.dart';
import '../data/models/purchase_order_model.dart';
import '../widgets/custom_app_bar.dart';
import 'dart:math'; // For generating unique item IDs
import '../../../../core/utils/screen_util_helper.dart'; // Add this import

class CreatePoScreen extends StatefulWidget {
  const CreatePoScreen({super.key});
  static const routeName = '/create-po';

  @override
  State<CreatePoScreen> createState() => _CreatePoScreenState();
}

class _CreatePoScreenState extends State<CreatePoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  final Random _random = Random();

  // Controllers for PO main form
  final _deliverToController = TextEditingController();
  final _emailIdController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _orderNoController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedAccount;
  String? _selectedVendor;
  DateTime? _creationDate;
  DateTime? _expectedDeliveryDate;

  // Example data for dropdowns
  final List<String> _accounts = ['ST. XYZ', 'Account B', 'Account C'];
  final List<String> _vendors = ['Vendor A', 'Vendor B', 'Vendor C'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    final initialDraft = context.read<PoManagementBloc>().state.currentPoDraft;
    _selectedAccount = initialDraft.account;
    _selectedVendor = initialDraft.vendorName;
    _deliverToController.text = initialDraft.deliverTo ?? '';
    _emailIdController.text = initialDraft.emailId ?? '';
    _mobileNumberController.text = initialDraft.mobileNumber ?? '';
    _orderNoController.text = initialDraft.orderNo ?? '';
    _creationDate = initialDraft.creationDate ?? DateTime.now();
    _expectedDeliveryDate = initialDraft.expectedDeliveryDate;
    _notesController.text = initialDraft.notes ?? '';
    String? effectiveAccount = initialDraft.account;
    if (effectiveAccount != null && effectiveAccount.isEmpty) {
      effectiveAccount = null;
    }
    _selectedAccount = effectiveAccount;

    String? effectiveVendor = initialDraft.vendorName;
    if (effectiveVendor != null && effectiveVendor.isEmpty) {
      effectiveVendor = null;
    }
    _selectedVendor = effectiveVendor;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PoManagementBloc>().add(
        UpdatePoFormField('creationDate', _creationDate),
      );
      if (_selectedAccount != null) {
        context.read<PoManagementBloc>().add(
          UpdatePoFormField('account', _selectedAccount),
        );
      }
      if (_selectedVendor != null) {
        context.read<PoManagementBloc>().add(
          UpdatePoFormField('vendorName', _selectedVendor),
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _deliverToController.dispose();
    _emailIdController.dispose();
    _mobileNumberController.dispose();
    _orderNoController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isCreationDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
      (isCreationDate ? _creationDate : _expectedDeliveryDate) ??
          DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isCreationDate) {
          _creationDate = picked;
          context.read<PoManagementBloc>().add(
            UpdatePoFormField('creationDate', picked),
          );
        } else {
          _expectedDeliveryDate = picked;
          context.read<PoManagementBloc>().add(
            UpdatePoFormField('expectedDeliveryDate', picked),
          );
        }
      });
    }
  }

  void _showAddItemDialog(BuildContext context, PoManagementBloc bloc) {
    final itemDetailsController = TextEditingController();
    final commentsController = TextEditingController();
    final quantityController = TextEditingController();
    final costPerUnitController = TextEditingController();
    final itemFormKey = GlobalKey<FormState>();

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          
          title: Text('Add Item to PO', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(18), fontWeight: FontWeight.bold)),
          contentPadding: EdgeInsets.all(ScreenUtilHelper.width(20)),
          content: Form(
            key: itemFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: itemDetailsController,
                    decoration: InputDecoration(labelText: 'Item Details*', labelStyle: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: commentsController,
                    decoration: InputDecoration(labelText: 'Comments', labelStyle: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
                  ),
                  TextFormField(
                    controller: quantityController,
                    decoration: InputDecoration(labelText: 'Quantity*', labelStyle: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
                    keyboardType: TextInputType.number,
                    validator: (v) => v!.isEmpty || int.tryParse(v) == null || int.parse(v) <= 0 ? 'Valid quantity required' : null,
                  ),
                  TextFormField(
                    controller: costPerUnitController,
                    decoration: InputDecoration(labelText: 'Cost Per Unit*', labelStyle: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (v) => v!.isEmpty || double.tryParse(v) == null || double.parse(v) <= 0 ? 'Valid cost required' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => GoRouter.of(dialogContext).pop(),
              child: Text('Cancel', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
            ),
            ElevatedButton(
              onPressed: () {
                if (itemFormKey.currentState!.validate()) {
                  final qty = int.parse(quantityController.text);
                  final cost = double.parse(costPerUnitController.text);
                  final newItem = POItemModel(
                    id: 'item_${_random.nextInt(10000)}',
                    itemDetails: itemDetailsController.text,
                    comments: commentsController.text,
                    quantity: qty,
                    costPerUnit: cost,
                    amount: qty * cost,
                  );
                  bloc.add(AddItemToPo(newItem));
                  GoRouter.of(dialogContext).pop();
                }
              },
              child: Text('Add Item', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    final poBloc = BlocProvider.of<PoManagementBloc>(context);

    return Scaffold(
      backgroundColor: AppColors.linen,
      appBar: CustomAppBar(
        showAddAction: true,
        addActionText: 'Add Items',
        onAddActionPressed: () {
          _showAddItemDialog(context, poBloc);
        },
        logoAssetPath: 'assets/images/edudibon_logo.png',
        pageTitle: 'PO Management',
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              color: AppColors.white,
              child: TabBar(
                controller: _tabController,
                labelColor: AppColors.secondaryDarker,
                unselectedLabelColor: AppColors.ash,
                indicatorColor: AppColors.secondaryDarker,
                
                labelStyle: TextStyle(fontSize: ScreenUtilHelper.fontSize(15), fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyle(fontSize: ScreenUtilHelper.fontSize(15)),
                tabs: const [
                  Tab(text: 'Create'),
                  Tab(text: 'Bills'),
                ],
              ),
            ),
            Expanded(
              child: BlocConsumer<PoManagementBloc, PoManagementState>(
                listener: (context, state) {
                  if (state.poCreationStatus == PoCreationStatus.success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Purchase Order created successfully!', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
                        backgroundColor: AppColors.success,
                      ),
                    );
                    GoRouter.of(context).pop();
                  } else if (state.poCreationStatus == PoCreationStatus.failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Error: ${state.poCreationErrorMessage ?? 'Could not create PO.'}',
                          style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)),
                        ),
                        backgroundColor: AppColors.error,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return TabBarView(
                    controller: _tabController,
                    children: [
                      _buildPoDetailsForm(context, poBloc, state.currentPoDraft),
                      _buildPoItemsSection(context, poBloc, state.currentPoDraft.items),
                    ],
                  );
                },
              ),
            ),
            if (_tabController.index == 0)
              _buildFormActions(context, poBloc),
          ],
        ),
      ),
    );
  }

  Widget _buildPoDetailsForm(
      BuildContext context,
      PoManagementBloc bloc,
      PurchaseOrderModel draft,
      ) {
    return SingleChildScrollView(
      
      padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdownField(
            'Select Account*',
            _selectedAccount,
            _accounts,
                (val) {
              setState(() => _selectedAccount = val);
              bloc.add(UpdatePoFormField('account', val));
            },
                (v) => v == null ? 'Account is required' : null,
          ),
          _buildDropdownField(
            'Select Vendor*',
            _selectedVendor,
            _vendors,
                (val) {
              setState(() => _selectedVendor = val);
              bloc.add(UpdatePoFormField('vendorName', val));
            },
                (v) => v == null ? 'Vendor is required' : null,
          ),
          _buildTextField(
            'Deliver To',
            _deliverToController,
                (val) => bloc.add(UpdatePoFormField('deliverTo', val)),
          ),
          _buildTextField(
            'Email ID',
            _emailIdController,
                (val) => bloc.add(UpdatePoFormField('emailId', val)),
            keyboardType: TextInputType.emailAddress,
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  'Mobile Number',
                  _mobileNumberController,
                      (val) => bloc.add(UpdatePoFormField('mobileNumber', val)),
                  keyboardType: TextInputType.phone,
                ),
              ),
              
              SizedBox(width: ScreenUtilHelper.width(16)),
              Expanded(
                child: _buildTextField(
                  'Order No',
                  _orderNoController,
                      (val) => bloc.add(UpdatePoFormField('orderNo', val)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildDateField(
                  context,
                  'Date*',
                  _creationDate,
                      () => _selectDate(context, true),
                ),
              ),
              
              SizedBox(width: ScreenUtilHelper.width(16)),
              Expanded(
                child: _buildDateField(
                  context,
                  'Expected Delivery Date',
                  _expectedDeliveryDate,
                      () => _selectDate(context, false),
                ),
              ),
            ],
          ),
          _buildTextField(
            'Notes',
            _notesController,
                (val) => bloc.add(UpdatePoFormField('notes', val)),
            maxLines: 3,
          ),
          
          SizedBox(height: ScreenUtilHelper.height(60)),
        ],
      ),
    );
  }

  Widget _buildPoItemsSection(
      BuildContext context,
      PoManagementBloc bloc,
      List<POItemModel> items,
      ) {
    if (items.isEmpty) {
      return Center(
        child: Padding(
          
          padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
          child: Text(
            'No items added to this Purchase Order yet. Click "+ Add Item" above.',
            textAlign: TextAlign.center,
            
            style: TextStyle(fontSize: ScreenUtilHelper.fontSize(15)),
          ),
        ),
      );
    }
    return ListView.builder(
      
      padding: EdgeInsets.all(ScreenUtilHelper.width(8)),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          
          margin: EdgeInsets.symmetric(
            vertical: ScreenUtilHelper.height(4),
            horizontal: ScreenUtilHelper.width(8),
          ),
          child: ListTile(
            title: Text(
              item.itemDetails,
              
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtilHelper.fontSize(16),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.comments != null && item.comments!.isNotEmpty)
                  Text(
                    'Comments: ${item.comments}',
                    
                    style: TextStyle(fontSize: ScreenUtilHelper.fontSize(13)),
                  ),
                Text(
                  'Qty: ${item.quantity}, Cost/Unit: ${item.costPerUnit.toStringAsFixed(2)}',
                  
                  style: TextStyle(fontSize: ScreenUtilHelper.fontSize(13)),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Amt: ${item.amount.toStringAsFixed(2)}',
                  
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtilHelper.fontSize(14),
                  ),
                ),
                IconButton(
                  
                  icon: Icon(Icons.delete_outline, color: AppColors.error, size: ScreenUtilHelper.scaleAll(24)),
                  onPressed: () => bloc.add(RemoveItemFromPo(item.id)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller,
      Function(String) onChanged, {
        TextInputType? keyboardType,
        int maxLines = 1,
        String? Function(String?)? validator,
      }) {
    return Padding(
      
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: ScreenUtilHelper.fontSize(14),
            ),
          ),
          
          SizedBox(height: ScreenUtilHelper.height(4)),
          TextFormField(
            controller: controller,
            
            style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                
                borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
              ),
              
              contentPadding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(12),
                vertical: ScreenUtilHelper.height(10),
              ),
            ),
            keyboardType: keyboardType,
            maxLines: maxLines,
            onChanged: onChanged,
            validator: validator,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(
      String label,
      String? currentValue,
      List<String> items,
      Function(String?) onChanged,
      String? Function(String?)? validator,
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: ScreenUtilHelper.fontSize(14),
            ),
          ),
          SizedBox(height: ScreenUtilHelper.height(4)),
          SizedBox(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(12),
                  vertical: ScreenUtilHelper.height(10),
                ),
              ),
              value: currentValue,
              hint: Text(
                label.replaceAll('*', '').trim(),
                style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)),
              ),
              itemHeight:50,
              items: items.map(
                    (item) => DropdownMenuItem(
                  value: item,
                  child: Text(item, style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
                ),
              ).toList(),
              onChanged: onChanged,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(
      BuildContext context,
      String label,
      DateTime? date,
      VoidCallback onTap,
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: ScreenUtilHelper.fontSize(14),
            ),
          ),
          
          SizedBox(height: ScreenUtilHelper.height(4)),
          InkWell(
            onTap: onTap,
            child: InputDecorator(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                ),
                
                contentPadding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(12),
                  vertical: ScreenUtilHelper.height(14),
                ),
              ),
              child: Text(
                date != null
                    ? DateFormat('dd/MM/yyyy').format(date)
                    : 'Select Date',
                
                style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormActions(BuildContext context, PoManagementBloc bloc) {
    return Padding(
      
      padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () {
              bloc.add(ResetPoForm());
              GoRouter.of(context).pop();
            },
            style: OutlinedButton.styleFrom(foregroundColor: AppColors.secondaryDarker),
            child: Text('Cancel', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
          ),
          
          SizedBox(width: ScreenUtilHelper.width(16)),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                bloc.add(AddNewPurchaseOrder(bloc.state.currentPoDraft));
              } else {
                if (_tabController.index != 0) _tabController.animateTo(0);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please correct the errors in the form.', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            },
            child: BlocBuilder<PoManagementBloc, PoManagementState>(
              builder: (context, state) {
                if (state.poCreationStatus == PoCreationStatus.submitting) {
                  return SizedBox(
                    
                    height: ScreenUtilHelper.scaleAll(20),
                    width: ScreenUtilHelper.scaleAll(20),
                    child: const CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: 2,
                    ),
                  );
                }
                return Text('Save', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)));
              },
            ),
          ),
        ],
      ),
    );
  }
}