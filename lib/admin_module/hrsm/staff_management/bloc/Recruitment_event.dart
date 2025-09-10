import 'package:equatable/equatable.dart';

abstract class RecruitmentEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class LoadRecruitmentData extends RecruitmentEvent {}
