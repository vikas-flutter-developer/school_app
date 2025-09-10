import 'package:equatable/equatable.dart';

import 'fees_bloc.dart';

abstract class FeeState extends Equatable {
  const FeeState();
  @override
  List<Object> get props => [];
}

class FeeInitial extends FeeState {}

class FeeLoading extends FeeState {}

class FeeLoaded extends FeeState {
  final List<Fee> fees;
  const FeeLoaded({required this.fees});
  @override
  List<Object> get props => [fees];
}

class FeeError extends FeeState {
  final String error;
  const FeeError({required this.error});
  @override
  List<Object> get props => [error];
}
