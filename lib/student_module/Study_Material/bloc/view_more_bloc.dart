import 'package:edudibon_flutter_bloc/student_module/Study_Material/bloc/view_more_event.dart';
import 'package:edudibon_flutter_bloc/student_module/Study_Material/bloc/view_more_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/study_material_model.dart';


class ViewMoreBloc extends Bloc<ViewMoreEvent, ViewMoreState> {
  final List<StudyMaterial> allMaterials = [
    StudyMaterial(title: "Quarter Year Exam Paper", details: "Includes questions from the first quarter of the year."),
    StudyMaterial(title: "Annual Exam Paper", details: "Complete set of annual examination question papers."),
    StudyMaterial(title: "First Term Exam Paper", details: "Covers syllabus from the first term of the academic year."),
  ];

  ViewMoreBloc() : super(ViewMoreLoading()) {
    on<LoadViewMoreMaterials>((event, emit) {
      emit(ViewMoreLoaded(allMaterials));
    });

    on<SearchViewMoreMaterials>((event, emit) {
      final filteredMaterials = allMaterials
          .where((material) => material.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(ViewMoreLoaded(filteredMaterials));
    });
  }
}
