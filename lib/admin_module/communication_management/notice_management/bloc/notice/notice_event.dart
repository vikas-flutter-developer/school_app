part of 'notice_bloc.dart';

abstract class NoticeEvent extends Equatable {
  const NoticeEvent();

  @override
  List<Object> get props => [];
}

class LoadNotices extends NoticeEvent {}

class CreateNotice extends NoticeEvent {
  final Notice notice;

  const CreateNotice(this.notice);

  @override
  List<Object> get props => [notice];
}

class UpdateNotice extends NoticeEvent {
  final Notice notice;

  const UpdateNotice(this.notice);

  @override
  List<Object> get props => [notice];
}

class DeleteNotice extends NoticeEvent {
  final String noticeId;

  const DeleteNotice(this.noticeId);

  @override
  List<Object> get props => [noticeId];
}

class SelectRecipientType extends NoticeEvent {
  final String recipientType;

  const SelectRecipientType(this.recipientType);

  @override
  List<Object> get props => [recipientType];
}

class SelectSendVia extends NoticeEvent {
  final String sendVia;

  const SelectSendVia(this.sendVia);

  @override
  List<Object> get props => [sendVia];
}

class ToggleSelectAllRecipients extends NoticeEvent {
  final bool selectAll;

  const ToggleSelectAllRecipients(this.selectAll);

  @override
  List<Object> get props => [selectAll];
}

class ToggleRecipientSelection extends NoticeEvent {
  final int index;
  final bool isSelected;

  const ToggleRecipientSelection(this.index, this.isSelected);

  @override
  List<Object> get props => [index, isSelected];
}

class SearchRecipients extends NoticeEvent {
  final String searchTerm;

  const SearchRecipients(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}
