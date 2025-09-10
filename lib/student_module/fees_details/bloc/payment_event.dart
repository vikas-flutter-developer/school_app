part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

// Event triggered when user initiates payment
class ProcessPayment extends PaymentEvent {
  final String amount;
  // Add other necessary payment details if needed (card info, etc.)
  final String paymentMethodId;
  const ProcessPayment({required this.paymentMethodId, required this.amount});

  @override
  List<Object> get props => [amount];
}

// Event possibly triggered by the success screen to navigate away
class NavigateHome extends PaymentEvent {}

// You might have other events like PaymentMethodSelected, etc.
class PaymentAttempted extends PaymentEvent {
  final String paymentMethodId; // e.g., 'card_3320', 'card_8067'

  const PaymentAttempted(this.paymentMethodId);

  @override
  List<Object> get props => [paymentMethodId];
}
