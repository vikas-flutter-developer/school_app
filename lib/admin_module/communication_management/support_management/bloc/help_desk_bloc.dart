import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/help_desk_models.dart';

part 'help_desk_event.dart';
part 'help_desk_state.dart';

class HelpDeskBloc extends Bloc<HelpDeskEvent, HelpDeskState> {
  HelpDeskBloc() : super(HelpDeskState()) {
    on<TabChanged>((event, emit) {
      emit(state.copyWith(currentTabIndex: event.tabIndex));
    });

    on<LoadTickets>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        // Simulate API call
        await Future.delayed(const Duration(seconds: 1));
        final tickets = [
          Ticket(
            id: '#20250319-PT003',
            title: 'Request for Transfer to Another Branch',
            status: 'Pending Approval',
            category: 'Staff Transfer',
            raisedBy: 'English Teacher (Anita Kapoor)',
            date: '18 March 2025, 3:30 PM',
            issue:
                'Requesting transfer to another branch for personal reasons.',
          ),
          Ticket(
            id: '#20250319-PT003',
            title: 'Request for Transfer to Another Branch',
            status: 'Pending Approval',
            category: 'Staff Transfer',
            raisedBy: 'English Teacher (Anita Kapoor)',
            date: '18 March 2025, 3:30 PM',
            issue:
                'Requesting transfer to another branch for personal reasons.',
          ),
          Ticket(
            id: '#20250319-PT003',
            title: 'Request for Transfer to Another Branch',
            status: 'Pending Approval',
            category: 'Staff Transfer',
            raisedBy: 'English Teacher (Anita Kapoor)',
            date: '18 March 2025, 3:30 PM',
            issue:
                'Requesting transfer to another branch for personal reasons.',
          ),
          // Add more tickets as needed
        ];
        emit(state.copyWith(tickets: tickets, isLoading: false));
      } catch (e) {
        emit(state.copyWith(error: e.toString(), isLoading: false));
      }
    });

    on<LoadSurveys>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        // Simulate API call
        await Future.delayed(const Duration(seconds: 1));
        final surveys = [
          Survey(
            name: 'Time Changing',
            startDate: '14 March, 2025',
            endDate: '19 March, 2025',
          ),
          Survey(
            name: 'Time Changing',
            startDate: '14 March, 2025',
            endDate: '19 March, 2025',
          ),
          Survey(
            name: 'Time Changing',
            startDate: '14 March, 2025',
            endDate: '19 March, 2025',
          ),
          Survey(
            name: 'Time Changing',
            startDate: '14 March, 2025',
            endDate: '19 March, 2025',
          ),
          // Add more surveys as needed
        ];
        emit(state.copyWith(surveys: surveys, isLoading: false));
      } catch (e) {
        emit(state.copyWith(error: e.toString(), isLoading: false));
      }
    });

    on<ApproveTicket>((event, emit) {
      // Handle ticket approval logic
    });

    on<RejectTicket>((event, emit) {
      // Handle ticket rejection logic
    });

    on<CancelSurvey>((event, emit) {
      // Handle survey cancellation logic
    });
  }
}
