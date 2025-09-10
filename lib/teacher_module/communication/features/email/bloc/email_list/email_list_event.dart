// email_list_event.dart
part of 'email_list_bloc.dart';

abstract class EmailListEvent extends Equatable {
  const EmailListEvent();
  @override
  List<Object> get props => [];
}

class LoadEmails extends EmailListEvent {}

class SearchEmailsChanged extends EmailListEvent {
  final String searchTerm;
  const SearchEmailsChanged(this.searchTerm);
  @override
  List<Object> get props => [searchTerm];
}

class DeleteEmail extends EmailListEvent {
  final String emailId;
  const DeleteEmail(this.emailId);
  @override
  List<Object> get props => [emailId];
}
