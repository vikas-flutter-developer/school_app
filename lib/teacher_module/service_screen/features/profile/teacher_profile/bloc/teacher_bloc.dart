import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import '../model/teacher_models.dart';

part 'teacher_event.dart';
part 'teacher_state.dart';

class TeacherBloc extends Bloc<TeacherFetchEvent, TeacherState> {
  TeacherBloc() : super(TeacherLoadingState()) {
    on<TeacherFetchEvent>((event, emit) async {
      try {
        emit(TeacherLoadingState());
        // final authToken = await LocalStorageService.getAuthToken(); // Get token

        // if (authToken == null) {
        //   emit(
        //     TeacherErrorState(
        //       'Authentication token not found. Please log in again.',
        //     ),
        //   );
        //   return;
        // }

        final response = await http.get(
          Uri.parse(
            "https://stage-api-edudibon.trinodepointers.com/core/teacher/info",
          ),
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJuczEyNWF6MjdtZ3UiLCJuYW1lIjoiQXpoYWdpIEsiLCJ0eiI6IkFzaWEvS29sa2F0YSIsImlhdCI6MTc0NTQ4MDM5NCwiZXhwIjoxNzQ1NTEzOTk0LCJhdWQiOiJlZHVESUJPTiIsImlzcyI6Imh0dHBzOi8vc3RhZ2UtZWR1ZGlib24udHJpbm9kZXBvaW50ZXJzLmNvbSIsImRhdGEiOiJnQUFBQUFCb0NlckswV2lQeDhYTnlDQlVXdWRRSXZzV0dDdFNoa3haSEdaWXpNNWx1NlROa1I3QVpOS1UxYkZLS09qWVR0bEw3bmpfVVVqNlEyZDBUUDZNcDVrTXhyNWdZMFN1bmstcnZMdDM0TUQ3aDRqbkY1RGFlMVBzNjlOa0s5bUJ2b0NTRWxrdl9nWklkdUNXbVRXOWs2TjQwQmNrd0gwT0VFZjJ6U1BUT0U4dE5ScGVzZTJ3LWNILWxUU21nNDJMbk81OS1HRE0ifQ.X1kL72b25GCjWTX_gY-BjGRhiH1V9CaxqywTV3XvwH0", // Use the retrieved token
          },
        );

        if (response.statusCode == 200) {
          emit(TeacherLoadedState(teacherModelsFromJson(response.body)));
        } else {
          emit(TeacherErrorState('Failed to load: ${response.statusCode}'));
        }
      } catch (e) {
        emit(TeacherErrorState('Error hiii: ${e.toString()}'));
      }
    });
  }
}
