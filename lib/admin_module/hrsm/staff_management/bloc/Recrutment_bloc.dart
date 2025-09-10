
import 'package:bloc/bloc.dart';

import '../model/Recrutment_model.dart';
import 'Recruitment_event.dart';
import 'Recruitment_state.dart';

class RecruitmentBloc extends Bloc<RecruitmentEvent, RecruitmentState> {
RecruitmentBloc() : super(RecruitmentLoading()) {
on<LoadRecruitmentData>((event, emit) {
// Populate with dummy data; replace with API calls or data source as needed
final interviews = [
ScheduledInterview(
title: 'Math Teacher - Secondary School',
candidates: [
Candidate(name: 'Kajal Pradhan', time: '12:00pm'),
Candidate(name: 'Shikha Singh', time: '02:00pm'),
Candidate(name: 'Mahesh Yadav', time: '03:30pm'),
],
),
ScheduledInterview(title: 'English Teacher - Primary School', candidates: []),
ScheduledInterview(title: 'Non Teaching', candidates: []),
];
final counts = {
'Teaching': 5,
'Non Teaching': 2,
'Admin': 0,
};
emit(RecruitmentLoaded(interviews: interviews, counts: counts));
});
}
}
