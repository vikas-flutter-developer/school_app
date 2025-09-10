// helpdesk_state.dart
part of 'helpdesk_bloc.dart';

enum HelpdeskStatus { initial, loading, success, failure }

// Models (Placeholders)
class HelpdeskStats extends Equatable {
  final int allQueries;
  final int open;
  final int closed;
  final int escalations;
  const HelpdeskStats({
    this.allQueries = 0,
    this.open = 0,
    this.closed = 0,
    this.escalations = 0,
  });
  @override
  List<Object> get props => [allQueries, open, closed, escalations];
}

class FaqItem extends Equatable {
  final String id;
  final String question;
  final String answer;
  const FaqItem({
    required this.id,
    required this.question,
    required this.answer,
  });
  @override
  List<Object> get props => [id, question, answer];
}

class HelpdeskState extends Equatable {
  final HelpdeskStatus status;
  final HelpdeskStats stats;
  final List<FaqItem> faqItems;
  final String searchTerm;
  final String? error;

  const HelpdeskState({
    this.status = HelpdeskStatus.initial,
    this.stats = const HelpdeskStats(),
    this.faqItems = const [],
    this.searchTerm = '',
    this.error,
  });

  // Dummy Data
  static List<FaqItem> get dummyFaqs => List.generate(
    4,
    (index) => FaqItem(
      id: 'faq_$index',
      question: 'How do I resolve issues releated to push notifications',
      answer:
          'Please check your device settings to ensure notifications are enabled for the app. Also, verify your network connection. If the issue persists, contact support via the "Create" button below.',
    ),
  );

  HelpdeskState copyWith({
    HelpdeskStatus? status,
    HelpdeskStats? stats,
    List<FaqItem>? faqItems,
    String? searchTerm,
    String? error,
  }) {
    return HelpdeskState(
      status: status ?? this.status,
      stats: stats ?? this.stats,
      faqItems: faqItems ?? this.faqItems,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  List<Object?> get props => [status, stats, faqItems, searchTerm, error];
}
