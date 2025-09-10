// part of 'splash_screen_bloc.dart';

// @immutable
// sealed class SplashScreenState {}

// final class SplashScreenInitial extends SplashScreenState {}



// part of 'splash_screen_bloc.dart';

// @immutable
// sealed class SplashScreenState {}

// final class SplashScreenInitial extends SplashScreenState {}



import 'package:equatable/equatable.dart';

abstract class SplashScreenState extends Equatable {
  const SplashScreenState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashScreenState {
  const SplashInitial();
}

class SplashScreenCompleted extends SplashScreenState {
  const SplashScreenCompleted();
}