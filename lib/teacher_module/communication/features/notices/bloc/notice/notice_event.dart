// --- Bloc ---
// notice_event.dart
part of 'notice_bloc.dart';

abstract class NoticeEvent extends Equatable {
  const NoticeEvent();
  @override
  List<Object> get props => [];
}

class LoadNotices extends NoticeEvent {}

class MarkNoticeAsRead extends NoticeEvent {
  final String noticeId;
  const MarkNoticeAsRead(this.noticeId);
  @override
  List<Object> get props => [noticeId];
}
