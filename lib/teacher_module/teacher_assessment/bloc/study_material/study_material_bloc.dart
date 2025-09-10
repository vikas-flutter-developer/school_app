import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/bloc/study_material/study_material_event.dart' show ChangeMaterialType, FilterStudyMaterials, LoadStudyMaterials, StudyMaterialsEvent;
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/models/study_material_model.dart' show StudyMaterials;
import 'package:equatable/equatable.dart';

part 'study_material_state.dart';

class StudyMaterialsBloc
    extends Bloc<StudyMaterialsEvent, StudyMaterialsState> {
  StudyMaterialsBloc() : super(StudyMaterialInitial()) {
    on<LoadStudyMaterials>(_onLoadStudyMaterials);
    on<FilterStudyMaterials>(_onFilterStudyMaterials);
    on<ChangeMaterialType>(_onChangeMaterialType);
  }

  Future<void> _onLoadStudyMaterials(
    LoadStudyMaterials event,
    Emitter<StudyMaterialsState> emit,
  ) async {
    emit(StudyMaterialLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      final materials = [
        StudyMaterials(
          id: '1',
          name: 'Chemistry Notes',
          date: '23/03/25',
          type: 'pdf',
          iconPath: 'assets/images/pdfimage.png',
        ),
        StudyMaterials(
          id: '2',
          name: 'Physics Formulas',
          date: '22/03/25',
          type: 'pdf',
          iconPath: 'assets/images/pdfimage.png',
        ),
        StudyMaterials(
          id: '3',
          name: 'Math Textbook',
          date: '21/03/25',
          type: 'book',
          iconPath: 'assets/images/bookimage.png',
        ),
        StudyMaterials(
          id: '4',
          name: 'Biology PPT',
          date: '20/03/25',
          type: 'ppt',
          iconPath: 'assets/images/pptimage.png',
        ),
        StudyMaterials(
          id: '5',
          name: 'Class Notes',
          date: '19/03/25',
          type: 'notes',
          iconPath: 'assets/images/pencilimage.png',
        ),
        StudyMaterials(
          id: '6',
          name: 'Science Diagrams',
          date: '18/03/25',
          type: 'image',
          iconPath: 'assets/images/photo-gallery.png',
        ),
        StudyMaterials(
          id: '7',
          name: 'Reference Materials',
          date: '17/03/25',
          type: 'folder',
          iconPath: 'assets/images/folder.png',
        ),
        StudyMaterials(
          id: '8',
          name: 'Additional Resources',
          date: '16/03/25',
          type: 'link',
          iconPath: 'assets/images/facebook.png',
        ),
      ];
      emit(StudyMaterialLoaded(materials: materials));
    } catch (e) {
      emit(StudyMaterialError(message: e.toString()));
    }
  }

  Future<void> _onFilterStudyMaterials(
    FilterStudyMaterials event,
    Emitter<StudyMaterialsState> emit,
  ) async {
    if (state is StudyMaterialLoaded) {
      final currentState = state as StudyMaterialLoaded;
      // Implement actual filtering logic here
      emit(
        currentState.copyWith(
          subjectFilter: event.subject,
          classFilter: event.classFilter,
          dateFilter: event.date,
        ),
      );
    }
  }

  void _onChangeMaterialType(
    ChangeMaterialType event,
    Emitter<StudyMaterialsState> emit,
  ) {
    if (state is StudyMaterialLoaded) {
      final currentState = state as StudyMaterialLoaded;
      emit(currentState.copyWith(selectedType: event.materialType));
    }
  }
}
