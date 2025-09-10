
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_route_event.dart';
import 'add_route_state.dart';

class AddRouteBloc extends Bloc<AddRouteEvent, AddRouteState> {
  AddRouteBloc() : super(const AddRouteState()) {
    on<FromChanged>((event, emit) => emit(state.copyWith(from: event.from)));

    on<ToChanged>((event, emit) => emit(state.copyWith(to: event.to)));

    on<StopAdded>((event, emit) {
      final updatedStops = List<String>.from(state.stops)..add(event.stop);
      emit(state.copyWith(stops: updatedStops));
    });

    on<RouteNameChanged>((event, emit) => emit(state.copyWith(routeName: event.name)));

    on<SubmitRoute>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      await Future.delayed(const Duration(seconds: 1)); // simulate an API call
      emit(state.copyWith(isSubmitting: false));
    });
  }
}
