part of 'fee_payment_bloc.dart';

abstract class FeePaymentState {}

class FeePaymentInitial extends FeePaymentState {}

class FeePaymentLoaded extends FeePaymentState {
  final int selectedIndex;

  FeePaymentLoaded({required this.selectedIndex});
}
