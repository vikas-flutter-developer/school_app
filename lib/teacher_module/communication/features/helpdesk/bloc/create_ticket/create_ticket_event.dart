// create_ticket_event.dart
part of 'create_ticket_bloc.dart';

enum TicketType { query, escalation }

abstract class CreateTicketEvent extends Equatable {
  const CreateTicketEvent();
  @override
  List<Object> get props => [];
}

class TicketTypeChanged extends CreateTicketEvent {
  final TicketType type;
  const TicketTypeChanged(this.type);
  @override
  List<Object> get props => [type];
}

class CommentChanged extends CreateTicketEvent {
  final String comment;
  const CommentChanged(this.comment);
  @override
  List<Object> get props => [comment];
}

class SubmitTicket extends CreateTicketEvent {}
