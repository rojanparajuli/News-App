// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:news/animation/loading/loading_screen.dart';
// import 'package:news/bloc/latest_news/latest_news_bloc.dart';
// import 'package:news/bloc/latest_news/latest_news_event.dart';
// import 'package:news/bloc/latest_news/latest_news_state.dart';

// class NewsScreen extends StatelessWidget {
//   const NewsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Trigger the FetchLatestNews event if not already loaded
//     context.read<LatestNewsBloc>().add(FetchLatestNews());

//     return Scaffold(
//       appBar: AppBar(title: const Text('Latest News')),
//       body: BlocBuilder<LatestNewsBloc, LatestNewsState>(
//         builder: (context, state) {
//           if (state is LatestNewsLoading) {
//             return const Center(child: LoadingScreen());
//           } else if (state is LatestNewsLoaded) {
//             if (state.latestNews.results == null || state.latestNews.results!.isEmpty) {
//               return const Center(child: Text('No news available at the moment.'));
//             }
//             return ListView.builder(
//               itemCount: state.latestNews.results?.length ?? 0,
//               itemBuilder: (context, index) {
//                 final article = state.latestNews.results![index];
//                 return ListTile(
//                   title: Text(article.title ?? 'No Title Available'),
//                   subtitle: Text(article.description ?? 'No Description Available'),
//                 );
//               },
//             );
//           } else if (state is LatestNewsError) {
//             return Center(child: Text(state.message));
//           }
//           return const Center(child: Text('Press the button to load news'));
//         },
//       ),
//     );
//   }
// }
