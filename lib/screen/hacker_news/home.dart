import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/animation/loading/loading_screen.dart';
import 'package:news/bloc/top_stories/top_stories_bloc.dart';
import 'package:news/bloc/top_stories/top_stories_state.dart';
import 'package:news/model/top_stories_data.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List topStoriesData = [];
  @override
  void initState() {
    super.initState();
    context.read<HackerNewsCubit>().fetchTopStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<HackerNewsCubit, TopStoriesState>(
        builder: (context, state) {
          print(state);

          if (state is TopStoriesLoading) {
            return const Center(
              child: LoadingScreen(),
            );
          }
          if (state is TopStoriesLoaded) {
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                TopStoriesData data = state.data[index];
                return ListTile(
                  title: Text(data.title ?? ''),
                  subtitle: Row(
                    children: [
                      Text("Type:${data.type ?? 'n/a'}"),
                      const SizedBox(
                        width: 25,
                      ),
                      Text("Time:${data.time.toString()}"),
                      const SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                  trailing: Text("By: ${data.by}"),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
