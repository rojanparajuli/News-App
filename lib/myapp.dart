import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/animation/splash/splash_screen.dart';
import 'package:news/bloc/best_stories/best_stories_cubit.dart';
import 'package:news/bloc/navigation/navigation_convix.dart';
import 'package:news/bloc/new_stories/new_stories_cubit.dart';
import 'package:news/bloc/splash/splash_bloc.dart';
import 'package:news/bloc/top_stories/top_stories_bloc.dart';
import 'package:news/service/best_stories/best_stories_service.dart';
import 'package:news/service/new_stories/new_stories_service.dart';
import 'package:news/service/top_stories/top_stories_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    NewsDataService newsDataService = NewsDataService();
    BestStoriesService bestStoriesService = BestStoriesService();
    NewStoriesService newStoriesService = NewStoriesService();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HackerNewsCubit(newsDataService)),
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(create: (_) => BestStoriesCubit(bestStoriesService)),
        BlocProvider(create: (_) => NewStoriesCubit(newStoriesService)),
        BlocProvider(create: (context) => SplashBloc()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
