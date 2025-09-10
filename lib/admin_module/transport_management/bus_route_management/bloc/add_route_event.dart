
import 'package:equatable/equatable.dart';

abstract class AddRouteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FromChanged extends AddRouteEvent {
  final String from;
  FromChanged(this.from);
  @override List<Object?> get props => [from];
}

class ToChanged extends AddRouteEvent {
  final String to;
  ToChanged(this.to);
  @override List<Object?> get props => [to];
}

class StopAdded extends AddRouteEvent {
  final String stop;
  StopAdded(this.stop);
  @override List<Object?> get props => [stop];
}

class RouteNameChanged extends AddRouteEvent {
  final String name;
  RouteNameChanged(this.name);
  @override List<Object?> get props => [name];
}

class SubmitRoute extends AddRouteEvent {}
