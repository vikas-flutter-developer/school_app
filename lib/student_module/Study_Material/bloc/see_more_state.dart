import 'package:equatable/equatable.dart';

import '../model/study_material_model.dart';


abstract class SeeMoreState extends Equatable {
  @override
  List<Object> get props => [];
}

/// ⏳ **Loading State**
class SeeMoreLoading extends SeeMoreState {}

/// ✅ **Loaded State**
class SeeMoreLoaded extends SeeMoreState {
  final List<StudyMaterial> materials;

  SeeMoreLoaded(this.materials);

  @override
  List<Object> get props => [materials];
}

/// ❌ **Error State**
class SeeMoreError extends SeeMoreState {
  final String message;

  SeeMoreError(this.message);

  @override
  List<Object> get props => [message];
}
