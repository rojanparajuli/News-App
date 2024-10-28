import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/animation/loading/loading_screen.dart';
import 'package:news/bloc/top_stories/top_stories_bloc.dart';
import 'package:news/bloc/top_stories/top_stories_state.dart';
import 'package:news/model/top_stories/top_stories_data.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ScrollController _scrollController = ScrollController();
  static const int _fetchIncrement = 20;
  int _fetchLimit = 99;

  @override
  void initState() {
    super.initState();
    _fetchInitialStories();

    // Infinite scroll listener
    _scrollController.addListener(_onScroll);
  }

  void _fetchInitialStories() {
    context.read<HackerNewsCubit>().fetchTopStories(limit: _fetchLimit);
  }

  void _onScroll() {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0 &&
        _fetchLimit < 500) {
      _loadMoreStories();
    }
  }

  Future<void> _refreshStories() async {
    setState(() {
      _fetchLimit = 99;
    });
    _fetchInitialStories();
  }

  void _loadMoreStories() {
    setState(() {
      _fetchLimit += _fetchIncrement;
    });
    context.read<HackerNewsCubit>().fetchTopStories(limit: _fetchLimit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Stories", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo[900],
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<HackerNewsCubit, TopStoriesState>(
        builder: (context, state) {
          if (state is TopStoriesLoading && _fetchLimit == 99) {
            return const Center(child: LoadingScreen());
          } else if (state is TopStoriesLoaded) {
            return _buildStoryList(state);
          } else if (state is TopStoriesError) {
            return _buildErrorState(state);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildStoryList(TopStoriesLoaded state) {
    return RefreshIndicator(
      onRefresh: _refreshStories,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        itemCount: state.data.length + 1,
        itemBuilder: (context, index) {
          if (index < state.data.length) {
            return _buildStoryCard(state.data[index], index);
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

  Widget _buildStoryCard(TopStoriesData data, int index) {
    return GestureDetector(
      onTap: () async {
        final Uri url = Uri.parse(data.url ?? '');
          await launchUrl(url, mode: LaunchMode.externalApplication);

      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          leading: CircleAvatar(
            backgroundColor: Colors.indigo[700],
            child: Text(
              '${index + 1}',
              style: const TextStyle(color: Colors.white),
            ),
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
          trailing: Text("By: ${data.by}",
              style: const TextStyle(color: Colors.indigo)),
        ),
      ),
    );
  }

  Widget _buildErrorState(TopStoriesError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 40),
          const SizedBox(height: 10),
          Text("Failed to load stories.",
              style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
}
