import 'package:equatable/equatable.dart';
import '../model/study_material_model.dart';


abstract class ViewMoreState extends Equatable {
  @override
  List<Object> get props => [];
}

class ViewMoreLoading extends ViewMoreState {}

class ViewMoreLoaded extends ViewMoreState {
  final List<StudyMaterial> materials;

  ViewMoreLoaded(this.materials);

  @override
  List<Object> get props => [materials];
}

class ViewMoreError extends ViewMoreState {}
