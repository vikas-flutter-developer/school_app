// helpdesk_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// Import Repos and Models

part 'helpdesk_event.dart';
part 'helpdesk_state.dart';

class TeacherHelpdeskBloc extends Bloc<HelpdeskEvent, HelpdeskState> {
  // final HelpdeskRepository _helpdeskRepository;
  // final FaqRepository _faqRepository;

  TeacherHelpdeskBloc(/* ...repositories... */) : super(const HelpdeskState()) {
    on<LoadHelpdeskData>(_onLoadData);
    on<SearchHelpdeskChanged>(_onSearchChanged);

    add(LoadHelpdeskData()); // Initial load
  }

  Future<void> _onLoadData(
    LoadHelpdeskData event,
    Emitter<HelpdeskState> emit,
  ) async {
    emit(state.copyWith(status: HelpdeskStatus.loading));
    try {
      // Simulate fetching stats and FAQs
      // final stats = await _helpdeskRepository.getStats();
      // final faqs = await _faqRepository.getFaqs(searchTerm: state.searchTerm);
      await Future.delayed(const Duration(milliseconds: 400));
      emit(
        state.copyWith(
          status: HelpdeskStatus.success,
          stats: const HelpdeskStats(), // Use fetched stats
          faqItems: HelpdeskState.dummyFaqs, // Use fetched FAQs
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: HelpdeskStatus.failure, error: e.toString()));
    }
  }

  void _onSearchChanged(
    SearchHelpdeskChanged event,
    Emitter<HelpdeskState> emit,
  ) {
    emit(state.copyWith(searchTerm: event.searchTerm));
    // Trigger reload/filter of FAQs if search affects FAQs
    add(LoadHelpdeskData()); // Or a specific event like FilterFaqs
  }
}
