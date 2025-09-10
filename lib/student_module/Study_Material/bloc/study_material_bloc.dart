import 'package:flutter_bloc/flutter_bloc.dart';
import 'study_material_event.dart';
import 'study_material_state.dart';
import '../model/study_material_model.dart';

class StudyMaterialBloc extends Bloc<StudyMaterialEvent, StudyMaterialState> {
  StudyMaterialBloc() : super(StudyMaterialLoading()) {
    on<LoadStudyMaterials>(_onLoadStudyMaterials);
  }

  Future<void> _onLoadStudyMaterials(
      LoadStudyMaterials event, Emitter<StudyMaterialState> emit) async {
    try {
      emit(StudyMaterialLoading());

      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      final materials = [
        StudyMaterial(title: "Academic", details: "Past Year Papers & Notes"),
        StudyMaterial(title: "Math", details: "Algebra & Calculus"),
        StudyMaterial(title: "Science", details: "Physics & Chemistry"),
        StudyMaterial(title: "History", details: "World War & Revolutions"),
      ];

      emit(StudyMaterialLoaded(materials: materials));
    } catch (e) {
      emit(StudyMaterialError(errorMessage: e.toString())); // ✅ Now it works!
    }
  }
}
