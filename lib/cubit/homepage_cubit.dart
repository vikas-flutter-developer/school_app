import 'package:bloc/bloc.dart';
import 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit() : super(HomepageLoading());  // ✅ Use correct initial state

  void updateHomeContent(String banner, List<String> services, String event, String report) {
    emit(HomepageLoaded(banner, services, event, report)); // ✅ Emit correct state
  }
}
