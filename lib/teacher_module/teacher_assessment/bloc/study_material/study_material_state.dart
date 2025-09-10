part of 'study_material_bloc.dart';

abstract class StudyMaterialsState extends Equatable {
  const StudyMaterialsState();

  @override
  List<Object> get props => [];
}

class StudyMaterialInitial extends StudyMaterialsState {}

class StudyMaterialLoading extends StudyMaterialsState {}

class StudyMaterialLoaded extends StudyMaterialsState {
  final List<StudyMaterials> materials;
  final String? subjectFilter;
  final String? classFilter;
  final String? dateFilter;
  final String selectedType;

  const StudyMaterialLoaded({
    required this.materials,
    this.subjectFilter,
    this.classFilter,
    this.dateFilter,
    this.selectedType = 'All',
  });

  StudyMaterialLoaded copyWith({
    List<StudyMaterials>? materials,
    String? subjectFilter,
    String? classFilter,
    String? dateFilter,
    String? selectedType,
  }) {
    return StudyMaterialLoaded(
      materials: materials ?? this.materials,
      subjectFilter: subjectFilter ?? this.subjectFilter,
      classFilter: classFilter ?? this.classFilter,
      dateFilter: dateFilter ?? this.dateFilter,
      selectedType: selectedType ?? this.selectedType,
    );
  }

  @override
  List<Object> get props => [
    materials,
    subjectFilter ?? '',
    classFilter ?? '',
    dateFilter ?? '',
    selectedType,
  ];
}

class StudyMaterialError extends StudyMaterialsState {
  final String message;

  const StudyMaterialError({required this.message});

  @override
  List<Object> get props => [message];
}
