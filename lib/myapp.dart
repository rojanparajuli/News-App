import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/best_stories/best_stories_cubit.dart';
import 'package:news/bloc/navigation/navigation_convix.dart';
import 'package:news/bloc/top_stories/top_stories_bloc.dart';
import 'package:news/screen/utilities/navigation.dart';
import 'package:news/service/best_stories/best_stories_service.dart';
import 'package:news/service/top_stories/top_stories_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    NewsDataService newsDataService = NewsDataService();
    BestStoriesService bestStoriesService = BestStoriesService();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HackerNewsCubit(newsDataService)),
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(create: (_)=> BestStoriesCubit(bestStoriesService)),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NavigationScreen(),
      ),
    );
  }
}
