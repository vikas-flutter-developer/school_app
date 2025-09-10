import 'package:edudibon_flutter_bloc/student_module/Study_Material/bloc/see_more_event.dart';
import 'package:edudibon_flutter_bloc/student_module/Study_Material/bloc/see_more_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/study_material_model.dart';


class SeeMoreBloc extends Bloc<SeeMoreEvent, SeeMoreState> {
  final List<StudyMaterial> _academicYears = [
    StudyMaterial(
        title: "Academic Year 2020-2021",
        details: "Past year question papers & solutions."),
    StudyMaterial(
        title: "Academic Year 2021-2022",
        details: "Previous year materials and notes."),
    StudyMaterial(
        title: "Academic Year 2022-2023",
        details: "Latest solved papers & guides."),
  ];

  SeeMoreBloc() : super(SeeMoreLoading()) {
    on<LoadMaterials>((event, emit) {
      emit(SeeMoreLoaded(_academicYears));
    });

    on<SearchMaterials>((event, emit) {
      final query = event.query.toLowerCase().trim();
      final filteredMaterials = _academicYears
          .where((material) => material.title.toLowerCase().contains(query))
          .toList();

      emit(SeeMoreLoaded(filteredMaterials));
    });
  }
}
