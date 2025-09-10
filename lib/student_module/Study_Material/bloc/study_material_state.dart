
import '../model/study_material_model.dart';

abstract class StudyMaterialState {}

class StudyMaterialLoading extends StudyMaterialState {}

class StudyMaterialLoaded extends StudyMaterialState {
  final List<StudyMaterial> materials;

  StudyMaterialLoaded({required this.materials});
}

class StudyMaterialError extends StudyMaterialState {
  final String errorMessage;

  StudyMaterialError({this.errorMessage = "An error occurred"});
}
