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
  final ScrollController _scrollController = ScrollController();
  static const int _incrementFetch = 20;
  int _currentLimit = 100;

  @override
  void initState() {
    super.initState();
    context.read<HackerNewsCubit>().fetchTopStories(limit: _currentLimit);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          _currentLimit < 500) {
        _loadMoreStories();
      }
    });
  }

  Future<void> _refreshStories() async {
    setState(() {
      _currentLimit = 100;
    });
    context.read<HackerNewsCubit>().fetchTopStories(limit: _currentLimit);
  }

  void _loadMoreStories() {
    setState(() {
      _currentLimit += _incrementFetch;
    });
    context.read<HackerNewsCubit>().fetchTopStories(limit: _currentLimit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Top Stories",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo[900],
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<HackerNewsCubit, TopStoriesState>(
        builder: (context, state) {
          if (state is TopStoriesLoading && _currentLimit == 100) {
            return const Center(
              child: LoadingScreen(),
            );
          }
          if (state is TopStoriesLoaded) {
            return RefreshIndicator(
              onRefresh: _refreshStories,
              child: ListView.builder(
                controller: _scrollController,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                itemCount: state.data.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.data.length) {
                    TopStoriesData data = state.data[index];
                    return GestureDetector(
                      onTap: (){},
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          leading: CircleAvatar(
                            backgroundColor: Colors.indigo[700],
                            child: Text('${index + 1}',
                                style: const TextStyle(color: Colors.white)),
                          ),
                          title: Text(
                            data.title ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Type: ${data.type ?? 'n/a'}",
                                    style: const TextStyle(color: Colors.grey)),
                                const SizedBox(width: 25),
                                Text("Time: ${data.time.toString()}",
                                    style: const TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                          trailing: Text(
                            "By: ${data.by}",
                            style: const TextStyle(color: Colors.indigo),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            );
          }
          if (state is TopStoriesError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 40),
                  const SizedBox(height: 10),
                  Text(
                    "Failed to load stories.",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
