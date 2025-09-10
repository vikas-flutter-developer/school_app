import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/bill_model.dart';
import '../../data/models/purchase_order_model.dart';
import '../../data/repo/po_repository.dart';

part 'po_management_event.dart';
part 'po_management_state.dart';

class PoManagementBloc extends Bloc<PoManagementEvent, PoManagementState> {
  final PoRepository poRepository;
  final Random _random = Random();

  PoManagementBloc({required this.poRepository})
    : super(const PoManagementState()) {
    on<LoadPurchaseOrders>(_onLoadPurchaseOrders);
    on<LoadBills>(_onLoadBills);
    on<AddNewPurchaseOrder>(_onAddNewPurchaseOrder);
    on<UpdatePoFormField>(_onUpdatePoFormField);
    on<AddItemToPo>(_onAddItemToPo);
    on<RemoveItemFromPo>(_onRemoveItemFromPo);
    on<ResetPoForm>(_onResetPoForm);
  }

  Future<void> _onLoadPurchaseOrders(
    LoadPurchaseOrders event,
    Emitter<PoManagementState> emit,
  ) async {
    emit(state.copyWith(poListStatus: PoManagementStatus.loading));
    try {
      final pos = await poRepository.getPurchaseOrders();
      emit(
        state.copyWith(
          poListStatus: PoManagementStatus.success,
          purchaseOrders: pos,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          poListStatus: PoManagementStatus.failure,
          poListErrorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadBills(
    LoadBills event,
    Emitter<PoManagementState> emit,
  ) async {
    emit(state.copyWith(billListStatus: PoManagementStatus.loading));
    try {
      final bills = await poRepository.getBills();
      emit(
        state.copyWith(
          billListStatus: PoManagementStatus.success,
          bills: bills,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          billListStatus: PoManagementStatus.failure,
          billListErrorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onAddNewPurchaseOrder(
    AddNewPurchaseOrder event,
    Emitter<PoManagementState> emit,
  ) async {
    emit(state.copyWith(poCreationStatus: PoCreationStatus.submitting));
    try {
      // Recalculate total amount based on items
      double totalAmount = event.purchaseOrder.items.fold(
        0.0,
        (sum, item) => sum + item.amount,
      );
      final poToSave = event.purchaseOrder.copyWith(
        amount: totalAmount,
        // Simulate server-side generation if not already present
        poNumber:
            event.purchaseOrder.poNumber.isEmpty
                ? 'PO${1000 + _random.nextInt(9000)}'
                : event.purchaseOrder.poNumber,
        createdNumber:
            event.purchaseOrder.createdNumber.isEmpty
                ? '#CR${100000 + _random.nextInt(900000)}'
                : event.purchaseOrder.createdNumber,
        creationDate: event.purchaseOrder.creationDate ?? DateTime.now(),
        id:
            event.purchaseOrder.id.isEmpty
                ? 'po_${DateTime.now().millisecondsSinceEpoch}'
                : event.purchaseOrder.id,
      );

      await poRepository.addPurchaseOrder(poToSave);
      emit(
        state.copyWith(
          poCreationStatus: PoCreationStatus.success,
          // Optionally, add to the list immediately or trigger a reload
        ),
      );
      add(LoadPurchaseOrders()); // Reload PO list
      add(ResetPoForm()); // Clear the form
    } catch (e) {
      emit(
        state.copyWith(
          poCreationStatus: PoCreationStatus.failure,
          poCreationErrorMessage: e.toString(),
        ),
      );
    }
  }

  void _onUpdatePoFormField(
    UpdatePoFormField event,
    Emitter<PoManagementState> emit,
  ) {
    PurchaseOrderModel draft = state.currentPoDraft;
    switch (event.fieldName) {
      case 'account':
        draft = draft.copyWith(account: event.value as String?);
        break;
      case 'vendorName': // Assuming vendor selection updates vendorName
        draft = draft.copyWith(vendorName: event.value as String?);
        break;
      case 'deliverTo':
        draft = draft.copyWith(deliverTo: event.value as String?);
        break;
      case 'emailId':
        draft = draft.copyWith(emailId: event.value as String?);
        break;
      case 'mobileNumber':
        draft = draft.copyWith(mobileNumber: event.value as String?);
        break;
      case 'orderNo':
        draft = draft.copyWith(orderNo: event.value as String?);
        break;
      case 'creationDate':
        draft = draft.copyWith(creationDate: event.value as DateTime?);
        break;
      case 'expectedDeliveryDate':
        draft = draft.copyWith(expectedDeliveryDate: event.value as DateTime?);
        break;
      case 'notes':
        draft = draft.copyWith(notes: event.value as String?);
        break;
    }
    emit(
      state.copyWith(
        currentPoDraft: draft,
        poCreationStatus: PoCreationStatus.editing,
      ),
    );
  }

  void _onAddItemToPo(AddItemToPo event, Emitter<PoManagementState> emit) {
    final updatedItems = List<POItemModel>.from(state.currentPoDraft.items)
      ..add(event.item);
    emit(
      state.copyWith(
        currentPoDraft: state.currentPoDraft.copyWith(items: updatedItems),
        poCreationStatus: PoCreationStatus.editing,
      ),
    );
  }

  void _onRemoveItemFromPo(
    RemoveItemFromPo event,
    Emitter<PoManagementState> emit,
  ) {
    final updatedItems =
        state.currentPoDraft.items
            .where((item) => item.id != event.itemId)
            .toList();
    emit(
      state.copyWith(
        currentPoDraft: state.currentPoDraft.copyWith(items: updatedItems),
        poCreationStatus: PoCreationStatus.editing,
      ),
    );
  }

  void _onResetPoForm(ResetPoForm event, Emitter<PoManagementState> emit) {
    emit(
      state.copyWith(
        poCreationStatus: PoCreationStatus.initial,
        currentPoDraft: const PurchaseOrderModel(
          id: '',
          poNumber: '',
          createdNumber: '',
          vendorName: '',
          status: POStatus.pending,
          amount: 0.0,
        ),
      ),
    );
  }
}
