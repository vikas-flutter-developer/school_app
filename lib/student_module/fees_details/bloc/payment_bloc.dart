import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<ProcessPayment>(_onProcessPayment);
    on<NavigateHome>(_onNavigateHome);
  }

  Future<void> _onProcessPayment(
    ProcessPayment event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentProcessing(event.paymentMethodId, event.amount.toString()));
    try {
      // Simulate network delay and payment processing
      await Future.delayed(const Duration(seconds: 2));

      // Simulate success/failure randomly for demo
      // In a real app, this would involve API calls
      final bool success = Random().nextBool();

      if (success) {
        // Simulate successful transaction details
        final details = TransactionDetails(
          transactionId:
              Random().nextInt(999999999).toString().padLeft(15, '0') +
              Random().nextInt(9999).toString(), // Longer ID
          timestamp: DateTime.now(),
          amount: event.amount,
          payerName: "Naveen B", // Example name
        );
        emit(PaymentSuccess(details: details));
      } else {
        emit(const PaymentFailure(error: "Payment declined by bank."));
      }
    } catch (e) {
      emit(
        PaymentFailure(error: "An unexpected error occurred: ${e.toString()}"),
      );
    }
  }

  // Optional: Handle navigation event if you prefer BLoC to manage it
  void _onNavigateHome(NavigateHome event, Emitter<PaymentState> emit) {
    // You could emit a specific state here if needed,
    // but often navigation is handled in the UI listener.
    // For simplicity, we might not need a specific state change here
    // if the UI handles navigation directly upon button press + pop.
    print("Navigate Home event received in BLoC");
    // Example: emit(PaymentNavigatingHome());
  }
}
