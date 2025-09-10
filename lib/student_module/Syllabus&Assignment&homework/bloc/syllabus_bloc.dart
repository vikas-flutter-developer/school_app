import 'package:flutter_bloc/flutter_bloc.dart';
import 'syllabus_event.dart';
import 'syllabus_state.dart';

class SyllabusBloc extends Bloc<SyllabusEvent, SyllabusState> {
  SyllabusBloc() : super(SyllabusInitial()) {
    on<LoadInitialSyllabus>(_onLoadInitialSyllabus);
    on<ViewMoreSyllabus>(_onViewMoreSyllabus);
  }

  void _onLoadInitialSyllabus(LoadInitialSyllabus event, Emitter<SyllabusState> emit) {
    List<String> syllabusList = ["Chemical Bonds", "Science", "Mathematics"];
    emit(SyllabusLoaded(syllabusList));
  }

  void _onViewMoreSyllabus(ViewMoreSyllabus event, Emitter<SyllabusState> emit) {
    // Handle 'View More' logic here
  }
}
