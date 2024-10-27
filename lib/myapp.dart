import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:news/bloc/latest_news/latest_news_bloc.dart';
// import 'package:news/bloc/latest_news/latest_news_event.dart';
import 'package:news/bloc/top_stories/top_stories_bloc.dart';
import 'package:news/screen/hacker_news/home.dart';
import 'package:news/service/top_stories_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    NewsDataService newsDataService = NewsDataService();
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (_) => LatestNewsBloc()..add(FetchLatestNews())),
        BlocProvider(create: (_) => HackerNewsCubit(newsDataService))
      ],
      child: const MaterialApp(
        home: Homepage(),
      ),
    );
  }
}
