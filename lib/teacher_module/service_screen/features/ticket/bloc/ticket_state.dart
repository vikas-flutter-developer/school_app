part of 'ticket_bloc.dart';

sealed class TicketState extends Equatable {
  const TicketState();
}

final class TicketInitial extends TicketState {
  @override
  List<Object> get props => [];
}
