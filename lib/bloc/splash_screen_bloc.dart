// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// part 'splash_screen_event.dart';
// part 'splash_screen_state.dart';

// class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
//   SplashScreenBloc() : super(SplashScreenInitial()) {
//     on<SplashScreenEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


// Events
abstract class SplashScreenEvent extends Equatable {
  const SplashScreenEvent();
  @override
  List<Object> get props => [];
}

class StartSplashScreen extends SplashScreenEvent {}

class SplashScreenAnimationCompleted extends SplashScreenEvent {} // New Event

// States
abstract class SplashScreenState extends Equatable {
  const SplashScreenState();
  @override
  List<Object> get props => [];
}

class SplashScreenInitial extends SplashScreenState {}

class SplashScreenCompleted extends SplashScreenState {}

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenInitial()) {
    on<StartSplashScreen>((event, emit) async {
      // We don't need a delay here anymore, the animation controls the delay
    });

    on<SplashScreenAnimationCompleted>((event, emit) async {
      emit(SplashScreenCompleted());
    });
  }
}
