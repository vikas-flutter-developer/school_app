part of 'help_desk_bloc.dart';

class HelpDeskState {
  final int currentTabIndex;
  final List<Ticket> tickets;
  final List<Survey> surveys;
  final bool isLoading;
  final String? error;

  HelpDeskState({
    this.currentTabIndex = 0,
    this.tickets = const [],
    this.surveys = const [],
    this.isLoading = false,
    this.error,
  });

  HelpDeskState copyWith({
    int? currentTabIndex,
    List<Ticket>? tickets,
    List<Survey>? surveys,
    bool? isLoading,
    String? error,
  }) {
    return HelpDeskState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      tickets: tickets ?? this.tickets,
      surveys: surveys ?? this.surveys,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
