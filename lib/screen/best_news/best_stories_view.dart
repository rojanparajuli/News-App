import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/animation/loading/loading_screen.dart';
import 'package:news/bloc/best_stories/best_stories_cubit.dart';
import 'package:news/bloc/best_stories/best_stories_state.dart';
import 'package:news/model/best_stories/best_stories_model.dart';
import 'package:news/service/best_stories/best_stories_service.dart';
import 'package:url_launcher/url_launcher.dart';

class BestStoriesScreen extends StatefulWidget {
  const BestStoriesScreen({super.key});

  @override
  State<BestStoriesScreen> createState() => _BestStoriesScreenState();
}

class _BestStoriesScreenState extends State<BestStoriesScreen> {
  late final BestStoriesCubit _cubit;
  BestStoriesService bestStoriesService = BestStoriesService();
  @override
  void initState() {
    super.initState();
    context.read<BestStoriesCubit>().fetchbeststories();
    _cubit = BestStoriesCubit(bestStoriesService);
    _cubit.fetchbeststories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Best Stories",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<BestStoriesCubit, BestStoriesState>(
        builder: (context, state) {
          if (state is BestStoriesStateLoading) {
            return const Center(child: LoadingScreen());
          } else if (state is BestStoriesStateLoaded) {
            final cubit = context.read<BestStoriesCubit>();
            final storiesIds = cubit.bestStoriesService.fetchbeststories();

            return FutureBuilder<List<int>>(
              future: storiesIds,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: LoadingScreen());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<BestStoriesCubit>().fetchbeststories();
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final storyId = snapshot.data![index];
                        return FutureBuilder<BestStories>(
                          future: cubit.getData(storyId),
                          builder: (context, storySnapshot) {
                            if (storySnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const ListTile(
                                title: Text("Loading story..."),
                              );
                            } else if (storySnapshot.hasError) {
                              return ListTile(
                                title: Text("Error: ${storySnapshot.error}"),
                              );
                            } else if (storySnapshot.hasData) {
                              final story = storySnapshot.data!;
                              return GestureDetector(
                                onTap: () async {
                                  print(story.url);
                                  print('hhhhh');
                                  final Uri url = Uri.parse(story.url ?? '');
                                  await launchUrl(url,
                                      mode: LaunchMode.externalApplication);
                                },
                                child: Card(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  elevation: 4,
                                  child: ListTile(
                                    title: Text(
                                      story.title ?? "No Title",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      story.by ?? "Unknown",
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    trailing: Text(
                                      "Score: ${story.score}",
                                      style:
                                          const TextStyle(color: Colors.orange),
                                    ),
                                    onTap: () {
                                      if (story.url != null) {}
                                    },
                                  ),
                                ),
                              );
                            } else {
                              return const ListTile(
                                title: Text("No story found"),
                              );
                            }
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text("No stories available"));
                }
              },
            );
          } else if (state is BestStoriesStateError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return const Center(
                child: Text("Press the button to load stories"));
          }
        },
      ),
    );
  }
}
