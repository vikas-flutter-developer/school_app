import 'package:equatable/equatable.dart';

import '../../models/syllabus_model.dart';

abstract class SyllabusState extends Equatable {
  const SyllabusState();

  @override
  List<Object> get props => [];
}

class SyllabusInitial extends SyllabusState {}

class SyllabusLoading extends SyllabusState {}

class SyllabusLoaded extends SyllabusState {
  final List<SyllabusItems> syllabusItems;
  final String? filter;

  const SyllabusLoaded({required this.syllabusItems, this.filter});

  SyllabusLoaded copyWith({
    List<SyllabusItems>? syllabusItems,
    String? filter,
  }) {
    return SyllabusLoaded(
      syllabusItems: syllabusItems ?? this.syllabusItems,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [syllabusItems, filter ?? ''];
}

class SyllabusError extends SyllabusState {
  final String message;

  const SyllabusError({required this.message});

  @override
  List<Object> get props => [message];
}
