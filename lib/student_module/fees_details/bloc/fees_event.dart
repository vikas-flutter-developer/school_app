import 'package:equatable/equatable.dart';

abstract class FeeEvent extends Equatable {
  const FeeEvent();
  @override
  List<Object> get props => [];
}

class FetchFees extends FeeEvent {}