import 'package:equatable/equatable.dart';

abstract class ViewMoreEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadViewMoreMaterials extends ViewMoreEvent {}

class SearchViewMoreMaterials extends ViewMoreEvent {
  final String query;

  SearchViewMoreMaterials(this.query);

  @override
  List<Object> get props => [query];
}
