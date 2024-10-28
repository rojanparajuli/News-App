import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/splash/splash_bloc.dart';
import 'package:news/bloc/splash/splash_event.dart';
import 'package:news/bloc/splash/splash_state.dart';
import 'package:news/screen/utilities/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<SplashBloc>(context).add(StartSplash());

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoaded) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const NavigationScreen()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) {
              double opacity = 0.0;
              if (state is SplashAnimating) {
                opacity = state.opacity;
              }

              return Hero(
                tag: 'logoHero',
                child: AnimatedBuilder(
                  animation: _scaleController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleController.value,
                      child: AnimatedOpacity(
                        opacity: opacity,
                        duration: const Duration(seconds: 2),
                        child: RotationTransition(
                          turns: _rotationController,
                          child: Image.asset(
                            'assets/unnamed.jpg',
                            width: 150,
                            height: 150,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
