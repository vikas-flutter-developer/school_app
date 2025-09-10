
import 'package:equatable/equatable.dart';

abstract class RouteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadRoutes extends RouteEvent {}

class SortByName extends RouteEvent {}

class SortByDistance extends RouteEvent {}

class SearchRoutes extends RouteEvent {
  final String query;
  SearchRoutes(this.query);

  @override
  List<Object?> get props => [query];
}
