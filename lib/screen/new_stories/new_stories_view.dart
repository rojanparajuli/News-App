import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/animation/loading/loading_screen.dart';
import 'package:news/bloc/new_stories/new_stories_cubit.dart';
import 'package:news/bloc/new_stories/new_stories_state.dart';
import 'package:news/model/new_stories/new_stories_model.dart';
import 'package:news/service/new_stories/new_stories_service.dart';
import 'package:url_launcher/url_launcher.dart';

class NewStoriesScreen extends StatefulWidget {
  final NewStoriesCubit? newStoriesCubit;

  const NewStoriesScreen({super.key, this.newStoriesCubit});

  @override
  State<NewStoriesScreen> createState() => _NewStoriesScreenState();
}

class _NewStoriesScreenState extends State<NewStoriesScreen> {
  late final NewStoriesCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = widget.newStoriesCubit ?? NewStoriesCubit(NewStoriesService());
    _cubit.fetchnewstories();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Latest News Stories',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: BlocBuilder<NewStoriesCubit, NewStoriesState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is NewStoriesStateLoading) {
            return const Center(child: LoadingScreen());
          } else if (state is NewStoriesStateLoaded) {
            return FutureBuilder<List<NewStoriesData>>(
              future:
                  Future.wait(state.storyIds.map((id) => _cubit.getData(id))),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: LoadingScreen());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No stories available',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                } else {
                  final stories = snapshot.data!;
                  return RefreshIndicator(
                    onRefresh: ()async{
                      return  _cubit.fetchnewstories();
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: stories.length,
                      itemBuilder: (context, index) {
                        final story = stories[index];
                        return GestureDetector(
                          onTap: ()async{

                            print(story.url);
                                  print('hhhhh');
                                  final Uri url = Uri.parse(story.url ?? '');
                                  await launchUrl(url,
                                      mode: LaunchMode.externalApplication);
                          },
                          child: Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(10),
                              title: Text(
                                story.title ?? 'No Title',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      story.by ?? 'Unknown Author',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      '${story.score} points',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey.shade600,
                                size: 16,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            );
          } else if (state is NewStoriesStateError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(
            child: Text(
              'No data available',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
