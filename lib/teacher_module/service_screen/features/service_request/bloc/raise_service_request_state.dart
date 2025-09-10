part of 'raise_service_request_cubit.dart';

abstract class RaiseServiceRequestState extends Equatable {
  const RaiseServiceRequestState();

  @override
  List<Object?> get props => [];
}

class RaiseServiceRequestInitial extends RaiseServiceRequestState {}

class RaiseServiceRequestSubmitting extends RaiseServiceRequestState {}

class RaiseServiceRequestSuccess extends RaiseServiceRequestState {}

class RaiseServiceRequestFailure extends RaiseServiceRequestState {
  final String message;

  const RaiseServiceRequestFailure(this.message);

  @override
  List<Object?> get props => [message];
}
