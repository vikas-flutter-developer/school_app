// part of 'splash_screen_bloc.dart';

// @immutable
// sealed class SplashScreenEvent {}

// part of 'splash_screen_bloc.dart';

// @immutable
// sealed class SplashScreenEvent {}


import 'package:equatable/equatable.dart';

abstract class SplashScreenEvent extends Equatable {
  const SplashScreenEvent();

  @override
  List<Object> get props => [];
}

class StartSplashScreen extends SplashScreenEvent {

}

