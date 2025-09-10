import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_tab_event.dart';
part 'app_tab_state.dart';

class AppTabBloc extends Bloc<AppTabEvent, AppTabState> {
  AppTabBloc() : super(const AppTabState()) {
    on<MainTabChanged>((event, emit) {
      emit(state.copyWith(mainTabIndex: event.index));
    });

    on<ExamEventsTabChanged>((event, emit) {
      emit(state.copyWith(examEventsTabIndex: event.index));
    });
  }
}
