import '../models/purchase_order_model.dart';
import '../models/bill_model.dart';
import 'dart:math';

abstract class PoRepository {
  Future<List<PurchaseOrderModel>> getPurchaseOrders();
  Future<void> addPurchaseOrder(PurchaseOrderModel po);
  Future<List<BillModel>> getBills();
  // Add methods for update/delete if needed
}

class MockPoRepository implements PoRepository {
  final Random _random = Random(); // This is fine, it's initialized first
  late final List<PurchaseOrderModel> _purchaseOrders; // Declare as late final
  late final List<BillModel> _bills; // Declare as late final

  // Constructor to initialize the lists
  MockPoRepository() {
    _purchaseOrders =
        List.generate(
          15,
          (i) => PurchaseOrderModel(
            id: 'po_$i',
            poNumber: 'PO${1000 + i}',
            createdNumber: '#CR${456789 + i * 10}', // Mockup had "CR" prefix
            vendorName: 'Vendor ${String.fromCharCode(65 + i % 5)}',
            status:
                POStatus.values[_random.nextInt(
                  POStatus.values.length,
                )], // Now _random is accessible
            amount: (100 + _random.nextInt(900)).toDouble(),
            creationDate: DateTime.now().subtract(Duration(days: i * 2)),
            items: [
              POItemModel(
                id: 'item_po${i}_1', // Make item ID more unique
                itemDetails: 'Sample Item A for PO $i',
                quantity: _random.nextInt(5) + 1, // Random quantity
                costPerUnit:
                    (20 + _random.nextInt(80)).toDouble(), // Random cost
                amount: 0, // Will be calculated
              ),
            ],
          ),
        ).map((po) {
          // Calculate total amount for each PO based on its items
          double totalAmount = 0;
          List<POItemModel> updatedItems = [];
          for (var item in po.items) {
            final itemAmount = item.quantity * item.costPerUnit;
            updatedItems.add(
              POItemModel(
                // Create new item with calculated amount
                id: item.id,
                itemDetails: item.itemDetails,
                quantity: item.quantity,
                costPerUnit: item.costPerUnit,
                amount: itemAmount, // Set the calculated amount
                comments: item.comments,
              ),
            );
            totalAmount += itemAmount;
          }
          return po.copyWith(items: updatedItems, amount: totalAmount);
        }).toList();

    _bills = List.generate(
      12,
      (i) => BillModel(
        id: 'bill_$i',
        billNo: '#B${789000 + i}',
        amount: (50 + _random.nextInt(500)).toDouble(),
        billDate: DateTime.now().subtract(Duration(days: i * 3)),
        dueDate: DateTime.now()
            .subtract(Duration(days: i * 3))
            .add(const Duration(days: 30)),
        status:
            BillStatus.values[_random.nextInt(
              BillStatus.values.length,
            )], // Now _random is accessible
      ),
    );
  }

  @override
  Future<List<PurchaseOrderModel>> getPurchaseOrders() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.from(_purchaseOrders); // Return a copy
  }

  @override
  Future<void> addPurchaseOrder(PurchaseOrderModel po) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Simulate ID generation and ensure all fields are consistent
    final poToInsert = po.copyWith(
      id: po.id.isEmpty ? 'po_${DateTime.now().millisecondsSinceEpoch}' : po.id,
      poNumber:
          po.poNumber.isEmpty
              ? 'PO${1000 + _purchaseOrders.length + _random.nextInt(100)}'
              : po.poNumber,
      createdNumber:
          po.createdNumber.isEmpty
              ? '#CR${456789 + (_purchaseOrders.length + 1) * 10 + _random.nextInt(10)}'
              : po.createdNumber,
      creationDate: po.creationDate ?? DateTime.now(),
      // Ensure amount is calculated from items if not already set
      amount: po.items.fold(0.0, (sum, item) => sum! + item.amount),
    );

    _purchaseOrders.insert(0, poToInsert);
  }

  @override
  Future<List<BillModel>> getBills() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.from(_bills); // Return a copy
  }
}
