part of 'payment_bloc.dart';

// Data class to hold success details
class TransactionDetails extends Equatable {
  final String transactionId;
  final DateTime timestamp;
  final String amount;
  final String payerName;

  const TransactionDetails({
    required this.transactionId,
    required this.timestamp,
    required this.amount,
    required this.payerName,
  });

  @override
  List<Object> get props => [transactionId, timestamp, amount, payerName];
}

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

// Initial state or state for the payment selection screen
class PaymentInitial extends PaymentState {}

// State when payment is being processed
class PaymentProcessing extends PaymentState {
  final String amount;
  final String processingMethodId;
  const PaymentProcessing(this.processingMethodId, this.amount);

  @override
  List<Object> get props => [processingMethodId];
}

// State when payment is successful
class PaymentSuccess extends PaymentState {
  final TransactionDetails details;

  const PaymentSuccess({required this.details});

  @override
  List<Object?> get props => [details];
}

// State when payment fails
class PaymentFailure extends PaymentState {
  final String error;

  const PaymentFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
