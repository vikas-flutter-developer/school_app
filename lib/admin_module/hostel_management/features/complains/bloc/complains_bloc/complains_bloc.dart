import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/complaint_model.dart'; // Adjust path as necessary

part 'complains_event.dart';
part 'complains_state.dart';

class ComplainsBloc extends Bloc<ComplainsEvent, ComplainsState> {
  ComplainsBloc() : super(const ComplainsState()) {
    on<LoadComplains>(_onLoadComplains);
    on<TabChanged>(_onTabChanged);
  }

  void _onLoadComplains(
    LoadComplains event,
    Emitter<ComplainsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    // Simulate API call or data fetching
    await Future.delayed(const Duration(milliseconds: 300));
    // In a real app, you would fetch this data from a service/repository
    emit(state.copyWith(studentComplaints: sampleComplaints, isLoading: false));
  }

  void _onTabChanged(TabChanged event, Emitter<ComplainsState> emit) {
    emit(state.copyWith(selectedTabIndex: event.tabIndex));
  }
}
