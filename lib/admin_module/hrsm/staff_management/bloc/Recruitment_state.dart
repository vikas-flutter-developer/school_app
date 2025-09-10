
import 'package:equatable/equatable.dart';

import '../model/Recrutment_model.dart';

abstract class RecruitmentState extends Equatable {
  @override
  List<Object> get props => [];
}
class RecruitmentLoading extends RecruitmentState {}
class RecruitmentLoaded extends RecruitmentState {
  final List<ScheduledInterview> interviews;
  final Map<String, int> counts; // e.g., {'Teaching': 5, 'Non Teaching': 2, 'Admin': 0}

  RecruitmentLoaded({required this.interviews, required this.counts});

  @override
  List<Object> get props => [interviews, counts];
}

