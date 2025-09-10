
import 'package:equatable/equatable.dart';

import '../model/route_model.dart';

abstract class RouteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RouteInitial extends RouteState {}

class RouteLoading extends RouteState {}

class RouteLoaded extends RouteState {
  final List<RouteModel> routes;

  RouteLoaded(this.routes);

  @override
  List<Object?> get props => [routes];
}
