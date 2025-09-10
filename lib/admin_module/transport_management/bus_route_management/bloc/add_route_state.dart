
import 'package:equatable/equatable.dart';

class AddRouteState extends Equatable {
  final String from;
  final String to;
  final List<String> stops;
  final String routeName;
  final bool isSubmitting;

  const AddRouteState({
    this.from = '',
    this.to = '',
    this.stops = const ['Stop 1'],
    this.routeName = '',
    this.isSubmitting = false,
  });

  AddRouteState copyWith({
    String? from,
    String? to,
    List<String>? stops,
    String? routeName,
    bool? isSubmitting,
  }) {
    return AddRouteState(
      from: from ?? this.from,
      to: to ?? this.to,
      stops: stops ?? this.stops,
      routeName: routeName ?? this.routeName,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [from, to, stops, routeName, isSubmitting];
}
