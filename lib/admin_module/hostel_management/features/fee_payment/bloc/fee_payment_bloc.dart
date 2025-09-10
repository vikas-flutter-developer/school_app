import 'package:flutter_bloc/flutter_bloc.dart';

part 'fee_payment_event.dart';
part 'fee_payment_state.dart';

class FeePaymentBloc extends Bloc<FeePaymentEvent, FeePaymentState> {
  FeePaymentBloc() : super(FeePaymentInitial()) {
    on<FeePaymentInitialEvent>((event, emit) {
      emit(FeePaymentLoaded(selectedIndex: 0));
    });
  }
}
