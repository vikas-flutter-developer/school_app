import 'package:edudibon_flutter_bloc/admin_module/transport_management/bus_route_management/bloc/route_event.dart';
import 'package:edudibon_flutter_bloc/admin_module/transport_management/bus_route_management/bloc/route_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/route_model.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  final List<RouteModel> allRoutes = [
    RouteModel(name: "Route A1", stops: 5, distance: 12, duration: 30, image: "assets/images/route_1.png"),
    RouteModel(name: "Route B2", stops: 8, distance: 18, duration: 45, image: "assets/images/route_2.png"),
    RouteModel(name: "Route C3", stops: 3, distance: 8, duration: 20, image: "assets/images/route_3.png"),
    RouteModel(name: "Route D4", stops: 6, distance: 15, duration: 35, image: "assets/images/route_4.png"),
  ];

  RouteBloc() : super(RouteInitial()) {
    on<LoadRoutes>((event, emit) {
      emit(RouteLoaded(List.from(allRoutes)));
    });

    on<SortByName>((event, emit) {
      final sorted = List<RouteModel>.from(allRoutes)
        ..sort((a, b) => a.name.compareTo(b.name));
      emit(RouteLoaded(sorted));
    });

    on<SortByDistance>((event, emit) {
      final sorted = List<RouteModel>.from(allRoutes)
        ..sort((a, b) => a.distance.compareTo(b.distance));
      emit(RouteLoaded(sorted));
    });

    on<SearchRoutes>((event, emit) {
      final query = event.query.toLowerCase();
      final filtered = allRoutes
          .where((route) => route.name.toLowerCase().contains(query))
          .toList();
      emit(RouteLoaded(filtered));
    });
  }
}
