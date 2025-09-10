/*
import 'package:bloc/bloc.dart';
import 'package:edudibon_flutter_bloc/Admin_Module_Classroom/admin_dashboard_bloc/dashboard_event.dart';
import 'package:edudibon_flutter_bloc/Admin_Module_Classroom/admin_dashboard_bloc/dashboard_state.dart';
import 'package:equatable/equatable.dart'; // Adjust path


class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<CardTapped>(_onCardTapped);
  }

  void _onCardTapped(CardTapped event, Emitter<DashboardState> emit) {
    // Logic to handle card tap
    if (event.item.routeName!.isNotEmpty) {
      print("DashboardBloc: Emitting DashboardNavigating for route ${event.item.routeName}");
      // Emit a state to indicate navigation is needed
      emit(DashboardNavigating(routeName: event.item.routeName ?? 'defaultRoute'));

      // You might want to return to the initial state afterwards,
      // depending on whether the listener consumes the state or not.
      // Or handle navigation directly in the listener and avoid emitting state here.
      // For this example, emitting State is the standard BLoC way for UI reactions.
      // You might need to add a mechanism to reset the state after navigation.
      // A common pattern is to emit a Loading/Processing state before navigation,
      // and a Loaded/Success state after the navigation is triggered by the listener.
      // For simplicity, we'll just emit Navigating and assume the listener handles it.
    } else {
      print("DashboardBloc: Card tapped for '${event.item.title}' has no routeName.");
      // Optionally emit a state for items without navigation, e.g., show a dialog
    }
  }
}*/
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<CardTapped>(_onCardTapped);
  }

  void _onCardTapped(CardTapped event, Emitter<DashboardState> emit) {
    // Check if the item has a valid route name
    final routeName = event.item.routeName;
    if (routeName != null && routeName.isNotEmpty) {
      // Emit the navigating state with the route name
      emit(DashboardNavigating(routeName: routeName));
      // Immediately reset to the initial state so we can navigate again later
      emit(DashboardInitial());
    }
    // If there's no route name, nothing happens, which is the correct behavior.
  }
}
