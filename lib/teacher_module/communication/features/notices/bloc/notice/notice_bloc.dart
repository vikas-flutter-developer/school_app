// notice_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart'; // For Color
import 'package:intl/intl.dart';

import '../../../../../../core/utils/app_colors.dart';
// Import Repo and Models

part 'notice_event.dart';
part 'notice_state.dart';

class TeacherNoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  // final NoticeRepository _noticeRepository;

  TeacherNoticeBloc(/*required this.noticeRepository*/) : super(const NoticeState()) {
    on<LoadNotices>(_onLoadNotices);
    on<MarkNoticeAsRead>(_onMarkAsRead);

    add(LoadNotices()); // Initial load
  }

  Future<void> _onLoadNotices(
    LoadNotices event,
    Emitter<NoticeState> emit,
  ) async {
    emit(state.copyWith(status: NoticeStatus.loading));
    try {
      // final notices = await _noticeRepository.getNotices();
      await Future.delayed(const Duration(milliseconds: 300));
      emit(
        state.copyWith(
          status: NoticeStatus.success,
          notices: NoticeState.dummyNotices,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: NoticeStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onMarkAsRead(
    MarkNoticeAsRead event,
    Emitter<NoticeState> emit,
  ) async {
    // Update state optimistically or after confirmation from repo
    final updatedNotices =
        state.notices.map((notice) {
          if (notice.id == event.noticeId) {
            // Create a new Notice object with isRead set to true
            return TeacherNotice(
              id: notice.id,
              title: notice.title,
              content: notice.content,
              date: notice.date,
              isRead: true,
              colorIndicator: notice.colorIndicator,
            );
          }
          return notice;
        }).toList();
    emit(state.copyWith(notices: updatedNotices));
    // try { await _noticeRepository.markAsRead(event.noticeId); } catch (e) { /* Handle error */ }
  }
}
