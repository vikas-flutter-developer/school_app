// notice_state.dart
part of 'notice_bloc.dart';

enum NoticeStatus { initial, loading, success, failure }

class NoticeState extends Equatable {
  final NoticeStatus status;
  final List<TeacherNotice>
  notices; // Assuming notices are grouped by date server-side or here
  final String? error;

  const NoticeState({
    this.status = NoticeStatus.initial,
    this.notices = const [],
    this.error,
  });

  // Dummy Data
  static List<TeacherNotice> get dummyNotices => List.generate(
    4,
    (index) => TeacherNotice(
      id: 'notice_$index',
      title: 'New School Timings',
      content:
          'Starting April 1, 2025, school timings will be 8:00 AM - 2:00 PM due to summer schedule.',
      date: DateTime.parse(
        '2015-03-12',
      ), // Example date from image (year seems off)
      isRead: index > 1, // Example read status
      colorIndicator:
          [
            AppColors.accentPink,
            AppColors.ptmStatus,
            AppColors.tertiaryAccentLight,
            AppColors.errorAccent,
          ][index % 4], // Example colors
    ),
  );

  NoticeState copyWith({
    NoticeStatus? status,
    List<TeacherNotice>? notices,
    String? error,
  }) {
    return NoticeState(
      status: status ?? this.status,
      notices: notices ?? this.notices,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, notices, error];
}

// Placeholder Notice model
class TeacherNotice extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final bool isRead;
  final Color colorIndicator; // Color from the side bar

  const TeacherNotice({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.isRead,
    required this.colorIndicator,
  });

  @override
  List<Object?> get props => [id, title, content, date, isRead, colorIndicator];
}
