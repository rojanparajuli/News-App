abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashAnimating extends SplashState {
  final double opacity;

  SplashAnimating(this.opacity);
}

class SplashLoaded extends SplashState {}
