import 'package:equatable/equatable.dart';

abstract class SeeMoreEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// 📂 **Load Initial Study Materials**
class LoadMaterials extends SeeMoreEvent {}

/// 🔍 **Search Study Materials**
class SearchMaterials extends SeeMoreEvent {
  final String query;

  SearchMaterials(this.query);

  @override
  List<Object> get props => [query];
}
