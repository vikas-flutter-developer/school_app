import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/visitor_pass_model.dart';

part 'visitor_event.dart';
part 'visitor_state.dart';

class VisitorBloc extends Bloc<VisitorEvent, VisitorState> {
  final List<VisitorPass> _mockVisitorPasses = [
    VisitorPass(
      id: 'vp001',
      date: DateTime(2025, 4, 3),
      visitorName: 'Prakash Shah',
      studentName: 'Mayuri Shah',
      studentClass: 'VII B',
      relation: 'Father',
      purpose: 'Casual',
      visitNumber: 2,
      inTime: '03:00pm',
      outTime: '00:00pm', // Assuming this means not checked out yet or default
      reasonForVisit: 'Re', // Short for reason
      status: VisitorStatus.newRequest,
    ),
    VisitorPass(
      id: 'vp002',
      date: DateTime(2025, 4, 3),
      visitorName: 'Prakash Shah',
      studentName: 'Mayuri Shah',
      purpose: 'Casual',
      visitNumber: 0, // Assuming it's part of the form, but not on this card
      studentClass: '', // Not shown on this card
      relation: '', // Not shown on this card
      status: VisitorStatus.pending,
    ),
    VisitorPass(
      id: 'vp003',
      date: DateTime(2025, 4, 3),
      visitorName: 'Prakash Shah',
      studentName: 'Mayuri Shah',
      purpose: 'Casual',
      visitNumber: 0,
      studentClass: '',
      relation: '',
      status: VisitorStatus.approved,
    ),
    VisitorPass(
      id: 'vp004',
      date: DateTime(2025, 4, 3),
      visitorName: 'Prakash Shah', // Name is cut off in screenshot
      studentName: 'Mayuri Shah',
      purpose: 'Casual',
      visitNumber: 0,
      studentClass: '',
      relation: '',
      status: VisitorStatus.denied,
    ),
  ];

  VisitorBloc() : super(VisitorInitial()) {
    on<LoadVisitorList>(_onLoadVisitorList);
    on<SubmitNewVisitorPass>(_onSubmitNewVisitorPass);
    on<ApproveVisitorPass>(_onApproveVisitorPass);
    on<DenyVisitorPass>(_onDenyVisitorPass);
  }

  Future<void> _onLoadVisitorList(
      LoadVisitorList event,
      Emitter<VisitorState> emit,
      ) async {
    emit(VisitorLoading());
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate API call
    emit(VisitorListLoadSuccess(List.from(_mockVisitorPasses)));
  }

  Future<void> _onSubmitNewVisitorPass(
      SubmitNewVisitorPass event,
      Emitter<VisitorState> emit,
      ) async {
    emit(VisitorLoading()); // Or a specific submission in progress state
    await Future.delayed(const Duration(seconds: 1));
    final newPass = VisitorPass(
      id: 'vp${_mockVisitorPasses.length + 1}',
      date: DateTime.now(),
      visitorName: event.visitorName,
      studentName: event.studentName,
      studentClass: event.studentClass,
      relation: event.relation,
      purpose: event.purpose,
      visitNumber: 1, // Assuming first visit for a new pass
      reasonForVisit: event.comment,
      status: VisitorStatus.pending, // New requests go to pending
    );
    _mockVisitorPasses.insert(0, newPass); // Add to top of the list
    emit(const VisitorFormSubmissionSuccess('Visitor pass request submitted.'));
    add(LoadVisitorList()); // Refresh list
  }

  Future<void> _onApproveVisitorPass(
      ApproveVisitorPass event,
      Emitter<VisitorState> emit,
      ) async {
    emit(VisitorLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    int index = _mockVisitorPasses.indexWhere((pass) => pass.id == event.passId);
    if (index != -1) {
      _mockVisitorPasses[index] = _mockVisitorPasses[index].copyWith(status: VisitorStatus.approved);
      emit(const VisitorActionSuccess('Visitor pass approved.'));
      add(LoadVisitorList());
    } else {
      emit(const VisitorError('Pass not found.'));
    }
  }

  Future<void> _onDenyVisitorPass(
      DenyVisitorPass event,
      Emitter<VisitorState> emit,
      ) async {
    emit(VisitorLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    int index = _mockVisitorPasses.indexWhere((pass) => pass.id == event.passId);
    if (index != -1) {
      _mockVisitorPasses[index] = _mockVisitorPasses[index].copyWith(status: VisitorStatus.denied);
      emit(const VisitorActionSuccess('Visitor pass denied.'));
      add(LoadVisitorList());
    } else {
      emit(const VisitorError('Pass not found.'));
    }
  }
}