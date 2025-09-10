// ... (other imports in create_po_screen.dart) ...
 // Or your chosen CustomAppBar
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../app_colors.dart';
import '../bloc/po_management/po_management_bloc.dart';
import '../data/models/purchase_order_model.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);
  static const routeName = '/create-po';

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _poDetailsFormKey = GlobalKey<FormState>(); // Key for the PO details form
  final Random _random = Random();

  // ... (controllers for PO main form: _deliverToController, etc. as before) ...
  // ... (_selectedAccount, _selectedVendor, etc. as before) ...

  @override
  void initState() {
    super.initState();
    // The image shows "Create" and "Bills" as top-level tabs on PO Management screen.
    // This screen, "Create PO", seems to have its own sub-navigation or content sections.
    // The image provided for "Add Item" looks like a form *within* the PO creation process.
    // Let's assume the "Create" and "Items" tabs are part of THIS screen.
    _tabController = TabController(length: 2, vsync: this); // Tab 1: PO Details, Tab 2: Add/Manage Items

    // ... (Initialize controllers and state from BLoC as before) ...
  }

  @override
  void dispose() {
    _tabController.dispose();
    // ... (Dispose other controllers as before) ...
    super.dispose();
  }

  // ... (_selectDate method as before) ...

  // This method will now build the UI shown in your "Add Item" image
  // It's no longer a dialog, but a dedicated form view for the "Items" tab.
  Widget _buildAddItemForm(BuildContext context, PoManagementBloc bloc, PurchaseOrderModel currentDraft) {
    // Controllers for the "Add Item" form fields
    final TextEditingController itemDetailsController = TextEditingController();
    final TextEditingController commentsController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController costPerUnitController = TextEditingController();
    final TextEditingController amountController = TextEditingController(); // Amount is usually calculated

    final GlobalKey<FormState> addItemFormKey = GlobalKey<FormState>();

    void calculateAmount() {
      final qty = int.tryParse(quantityController.text) ?? 0;
      final cost = double.tryParse(costPerUnitController.text) ?? 0.0;
      amountController.text = (qty * cost).toStringAsFixed(2);
    }

    quantityController.addListener(calculateAmount);
    costPerUnitController.addListener(calculateAmount);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: addItemFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildLabeledTextField(
              label: 'Items Details',
              controller: itemDetailsController,
              validator: (v) => v!.isEmpty ? 'Item details are required' : null,
            ),
            _buildLabeledTextField(
              label: 'Comments',
              controller: commentsController,
              maxLines: 2, // Allow more space for comments
            ),
            Row(
              children: [
                Expanded(
                  child: _buildLabeledTextField(
                    label: 'Quantity',
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v!.isEmpty) return 'Required';
                      if (int.tryParse(v) == null || int.parse(v) <= 0) return 'Invalid qty';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildLabeledTextField(
                    label: 'Cost Per Unit',
                    controller: costPerUnitController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (v) {
                      if (v!.isEmpty) return 'Required';
                      if (double.tryParse(v) == null || double.parse(v) <= 0) return 'Invalid cost';
                      return null;
                    },
                  ),
                ),
              ],
            ),
            _buildLabeledTextField(
              label: 'Amount',
              controller: amountController,
              readOnly: true, // Amount is calculated
              fillColor: AppColors.linen, // Indicate it's read-only
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // "Remove" could mean clear the form, or remove the last added item.
                    // For now, let's clear the form.
                    addItemFormKey.currentState?.reset();
                    itemDetailsController.clear();
                    commentsController.clear();
                    quantityController.clear();
                    costPerUnitController.clear();
                    amountController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Form cleared'), duration: Duration(seconds: 1),)
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.ash.withOpacity(0.5)),
                    foregroundColor: AppColors.ash,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Remove'), // Or "Clear"
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    if (addItemFormKey.currentState!.validate()) {
                      final newItem = POItemModel(
                        id: 'item_${_random.nextInt(100000)}', // Temp client-side ID
                        itemDetails: itemDetailsController.text,
                        comments: commentsController.text,
                        quantity: int.parse(quantityController.text),
                        costPerUnit: double.parse(costPerUnitController.text),
                        amount: double.parse(amountController.text),
                      );
                      bloc.add(AddItemToPo(newItem));
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Item added to PO draft! View in "Review Items" tab.'), duration: Duration(seconds: 2),)
                      );
                      // Optionally clear form after adding
                      addItemFormKey.currentState?.reset();
                      itemDetailsController.clear();
                      commentsController.clear();
                      quantityController.clear();
                      costPerUnitController.clear();
                      amountController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary, // Darker purple from image
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Add Item', style: TextStyle(color: AppColors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper for creating labeled text fields matching the style
  Widget _buildLabeledTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool readOnly = false,
    int maxLines = 1,
    Color? fillColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.ash.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: AppColors.cloud),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: AppColors.cloud),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              filled: fillColor != null,
              fillColor: fillColor,
            ),
            keyboardType: keyboardType,
            validator: validator,
            readOnly: readOnly,
            maxLines: maxLines,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }


  // This section will now display the list of items added to the current PO draft.
  Widget _buildReviewPoItemsSection(BuildContext context, PoManagementBloc bloc, List<POItemModel> items) {
    if (items.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'No items added to this Purchase Order yet.\nGo to the "Add Item" tab to add items.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.ash, fontSize: 16),
          ),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          elevation: 1.5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              title: Text(item.itemDetails, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.comments != null && item.comments!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text('Comments: ${item.comments}', style: const TextStyle(fontSize: 13)),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text('Qty: ${item.quantity}  |  Cost/Unit: ${item.costPerUnit.toStringAsFixed(2)}', style: const TextStyle(fontSize: 13)),
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Amt: ${item.amount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.primary)),
                  const SizedBox(height: 4),
                  InkWell( // Making remove action more prominent
                    onTap: () => bloc.add(RemoveItemFromPo(item.id)),
                    child: Icon(Icons.delete_outline, color: AppColors.errorDark, size: 22),
                  )
                ],
              )
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final poBloc = BlocProvider.of<PoManagementBloc>(context);

    return Scaffold(
      // Use the TwoRowAppBar here, assuming it's the app's standard
      appBar: CustomAppBar(
        logoAssetPath: 'assets/images/edudibon_logo.png', // Your logo
        pageTitle: 'PO Management', // Or "Create Purchase Order"
        showBackButton: true,
        notificationCount: 3, // Example
        // showAddAction: false, // No global "+Add PO" on this specific form screen
      ),
      backgroundColor: AppColors.white, // Image background is white for the form area
      body: Column(
        children: [
          // The "Create" / "Bills" segmented control from the image
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withOpacity(0.3), // Lighter purple background
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary, // Darker purple for selected
                ),
                labelColor: AppColors.white,
                unselectedLabelColor: AppColors.primary.withOpacity(0.9),
                labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                tabs: const [
                  Tab(text: 'PO Details'), // Was "Create" in PO Management screen, now "PO Details"
                  Tab(text: 'Add Item(s)'),   // Was "Bills" in PO Management, now specifically for items
                ],
                onTap: (index) {
                  // Hide keyboard when switching tabs
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ),
          Expanded(
            child: BlocConsumer<PoManagementBloc, PoManagementState>(
              listener: (context, state) {
                if (state.poCreationStatus == PoCreationStatus.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Purchase Order created successfully!'), backgroundColor: AppColors.success),
                  );
                  GoRouter.of(context).pop(); // Go back
                } else if (state.poCreationStatus == PoCreationStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${state.poCreationErrorMessage ?? 'Could not create PO.'}'), backgroundColor: AppColors.error),
                  );
                }
              },
              builder: (context, state) {
                // The TabBarView children are now the PO Details form and the Add Item form
                return TabBarView(
                  controller: _tabController,
                  children: [
                    // Tab 1: PO Details Form (your existing _buildPoDetailsForm)
                    // Make sure to wrap _buildPoDetailsForm in a Form widget with _poDetailsFormKey
                    Form(
                        key: _poDetailsFormKey,
                        child: _buildPoDetailsForm(context, poBloc, state.currentPoDraft)
                    ),

                    // Tab 2: Add Item Form and Review Items
                    Column(
                      children: [
                        _buildAddItemForm(context, poBloc, state.currentPoDraft), // The form from the image
                        const Divider(height: 20, thickness: 1),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Text("Items Added to PO", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: _buildReviewPoItemsSection(context, poBloc, state.currentPoDraft.items),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          // Global Save/Cancel for the entire PO (usually shown when on PO Details tab)
          // You might want to conditionally show this based on _tabController.index
          if (_tabController.index == 0) // Show Save/Cancel only when on "PO Details" tab
            _buildFormActions(context, poBloc), // Your existing Save/Cancel buttons
        ],
      ),
    );
  }

  // Assume _buildPoDetailsForm and _buildFormActions (Save/Cancel buttons)
  // are defined as they were in the previous `CreatePoScreen` version.
  // Make sure _buildPoDetailsForm uses _buildLabeledTextField for consistency.

  Widget _buildPoDetailsForm(BuildContext context, PoManagementBloc bloc, PurchaseOrderModel draft) {
    // ... (Your existing PO details form using _buildLabeledTextField helper)
    // Example:
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildLabeledTextField(label: "Deliver To", controller: _deliverToController,
              validator: (val) => val!.isEmpty ? 'Required' : null,
              // onChanged: (val) => bloc.add(UpdatePoFormField('deliverTo', val),),
          ),
          // ... other fields for PO details ...
        ],
      ),
    );
  }
  final _deliverToController = TextEditingController(); // Make sure these are defined in the state class

  Widget _buildFormActions(BuildContext context, PoManagementBloc bloc) {
    // ... (Your existing Save/Cancel buttons for the entire PO)
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row( /* ... Save and Cancel buttons ... */ )
    );
  }
}