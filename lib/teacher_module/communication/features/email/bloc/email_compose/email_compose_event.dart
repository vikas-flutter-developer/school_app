// email_compose_event.dart
part of 'email_compose_bloc.dart';

abstract class EmailComposeEvent extends Equatable {
  const EmailComposeEvent();
  @override
  List<Object> get props => [];
}

class LoadComposeData
    extends EmailComposeEvent {} // Load 'From' options, recipient groups

class SenderSelected extends EmailComposeEvent {
  final String senderEmail; // Or ID
  const SenderSelected(this.senderEmail);
  @override
  List<Object> get props => [senderEmail];
}

class RecipientGroupToggled extends EmailComposeEvent {
  final String groupName;
  final bool isSelected;
  const RecipientGroupToggled(this.groupName, this.isSelected);
  @override
  List<Object> get props => [groupName, isSelected];
}

class SubjectChanged extends EmailComposeEvent {
  final String subject;
  const SubjectChanged(this.subject);
  @override
  List<Object> get props => [subject];
}

class BodyChanged extends EmailComposeEvent {
  final String body;
  const BodyChanged(this.body);
  @override
  List<Object> get props => [body];
}

class SendEmail extends EmailComposeEvent {}
