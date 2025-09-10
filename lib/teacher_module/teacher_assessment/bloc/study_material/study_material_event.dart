import 'package:equatable/equatable.dart';

abstract class StudyMaterialsEvent extends Equatable {
  const StudyMaterialsEvent();

  @override
  List<Object> get props => [];
}

class LoadStudyMaterials extends StudyMaterialsEvent {
  const LoadStudyMaterials();
}

class FilterStudyMaterials extends StudyMaterialsEvent {
  final String? subject;
  final String? classFilter;
  final String? date;

  const FilterStudyMaterials({this.subject, this.classFilter, this.date});

  @override
  List<Object> get props => [subject ?? '', classFilter ?? '', date ?? ''];
}

class ChangeMaterialType extends StudyMaterialsEvent {
  final String materialType;

  const ChangeMaterialType(this.materialType);

  @override
  List<Object> get props => [materialType];
}
