import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../model/notice_model.dart';

part 'notice_event.dart';
part 'notice_state.dart';

class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  NoticeBloc()
    : super(
        NoticeState(
          notices: [],
          recipients: List.generate(
            30,
            (index) =>
                Recipient(name: 'Ansh Gupta', number: '999999999${index % 30}'),
          ),
          selectedRecipients: List.generate(30, (index) => false),
        ),
      ) {
    on<LoadNotices>(_onLoadNotices);
    on<CreateNotice>(_onCreateNotice);
    on<UpdateNotice>(_onUpdateNotice);
    on<DeleteNotice>(_onDeleteNotice);
    on<SelectRecipientType>(_onSelectRecipientType);
    on<SelectSendVia>(_onSelectSendVia);
    on<ToggleSelectAllRecipients>(_onToggleSelectAllRecipients);
    on<ToggleRecipientSelection>(_onToggleRecipientSelection);
    on<SearchRecipients>(_onSearchRecipients);
  }

  Future<void> _onLoadNotices(
    LoadNotices event,
    Emitter<NoticeState> emit,
  ) async {
    // Simulate loading notices from a data source
    await Future.delayed(const Duration(milliseconds: 500));
    emit(
      state.copyWith(
        notices: [
          Notice(
            id: '1',
            title: 'New School Timings',
            body:
                'Starting April 1, 2025, school timings will be 8:00 AM - 2:00 PM due to summer schedule.',
            status: 'Draft',
            statusColor: AppColors.warningAccent,
            bgColor: AppColors.ivory,
            barColor: AppColors.dottedLineColor,
            sentTo: 'All Teachers',
            showEditDelete: true,
          ),
          Notice(
            id: '2',
            title: 'PTM Announcement',
            body:
                'Parent-Teacher Meeting on July 10th, 2025, at 10:00 AM in the main hall.',
            status: 'Published',
            statusColor: AppColors.ptmStatus,
            bgColor: AppColors.ivory,
            barColor: AppColors.ptmBar,
            sentTo: 'Everyone',
            showEditDelete: false,
          ),
          Notice(
            id: '3',
            title: 'Holiday Notice',
            body: 'School will be closed on July 5th, 2025, for Eid al-Adha.',
            status: 'Scheduled',
            statusColor: AppColors.holidayStatus,
            bgColor: AppColors.ivory,
            barColor: AppColors.holidayBar,
            sentTo: 'Everyone',
            showEditDelete: false,
          ),
          Notice(
            id: '4',
            title: 'Result Declaration',
            body: 'Semester 1 results will be declared on January 20, 2025.',
            status: 'Draft',
            statusColor: AppColors.warningAccent,
            bgColor: AppColors.ivory,
            barColor: AppColors.resultBar,
            sentTo: 'Everyone',
            showEditDelete: true,
          ),
        ],
      ),
    );
  }

  Future<void> _onCreateNotice(
    CreateNotice event,
    Emitter<NoticeState> emit,
  ) async {
    final notices = List<Notice>.from(state.notices)..add(event.notice);
    emit(state.copyWith(notices: notices));
  }

  Future<void> _onUpdateNotice(
    UpdateNotice event,
    Emitter<NoticeState> emit,
  ) async {
    final notices = List<Notice>.from(state.notices);
    final index = notices.indexWhere((notice) => notice.id == event.notice.id);
    if (index != -1) {
      notices[index] = event.notice;
      emit(state.copyWith(notices: notices));
    }
  }

  Future<void> _onDeleteNotice(
    DeleteNotice event,
    Emitter<NoticeState> emit,
  ) async {
    final notices = List<Notice>.from(
      state.notices.where((notice) => notice.id != event.noticeId),
    );
    emit(state.copyWith(notices: notices));
  }

  void _onSelectRecipientType(
    SelectRecipientType event,
    Emitter<NoticeState> emit,
  ) {
    emit(state.copyWith(selectedRecipientType: event.recipientType));
  }

  void _onSelectSendVia(SelectSendVia event, Emitter<NoticeState> emit) {
    emit(state.copyWith(selectedSendVia: event.sendVia));
  }

  void _onToggleSelectAllRecipients(
    ToggleSelectAllRecipients event,
    Emitter<NoticeState> emit,
  ) {
    emit(
      state.copyWith(
        selectAll: event.selectAll,
        selectedRecipients: List<bool>.filled(
          state.recipients.length,
          event.selectAll,
        ),
      ),
    );
  }

  void _onToggleRecipientSelection(
    ToggleRecipientSelection event,
    Emitter<NoticeState> emit,
  ) {
    final selectedRecipients = List<bool>.from(state.selectedRecipients);
    selectedRecipients[event.index] = event.isSelected;

    final allSelected = selectedRecipients.every((selected) => selected);

    emit(
      state.copyWith(
        selectedRecipients: selectedRecipients,
        selectAll: allSelected,
      ),
    );
  }

  void _onSearchRecipients(SearchRecipients event, Emitter<NoticeState> emit) {
    emit(state.copyWith(searchTerm: event.searchTerm));
  }
}
