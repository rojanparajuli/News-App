import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';
import 'dart:async';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<StartSplash>(_onStartSplash);
  }

  Future<void> _onStartSplash(
      StartSplash event, Emitter<SplashState> emit) async {
    emit(SplashAnimating(0.0));

    await Future.delayed(const Duration(milliseconds: 500));
    emit(SplashAnimating(1.0));

    await Future.delayed(const Duration(seconds: 2));
    emit(SplashLoaded());
  }
}
