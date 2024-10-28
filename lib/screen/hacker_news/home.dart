import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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

  void _loadMoreStories() {
    _fetchLimit += _fetchIncrement;
    print('jjjjjjjjjjjj $_fetchLimit');
    context.read<HackerNewsCubit>().fetchTopStories(limit: _fetchLimit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:  Text("Top Stories", style: GoogleFonts.lora(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<HackerNewsCubit, TopStoriesState>(
        builder: (context, state) {
          print('ttttttttttttt');
          if (state is TopStoriesLoading) {
            return const Center(child: LoadingScreen());
          } else if (state is TopStoriesLoaded) {
            return _buildStoryList(state);
          } else if (state is TopStoriesError) {
            return _buildErrorState(state);
          }

          print('unknown state $state');
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildStoryList(TopStoriesLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        return context.read<HackerNewsCubit>().fetchTopStories(limit: 99);
      },
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
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.title ?? '',
              style: GoogleFonts.lora(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Type: ${data.type ?? 'n/a'}",
                  style:  GoogleFonts.lora(color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  "Time: ${data.time.toString()}",
                  style:GoogleFonts.lora(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "By: ${data.by}",
                style: GoogleFonts.lora(color: Colors.indigo),
              ),
            ),
          ],
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
              style: GoogleFonts.lora(color: Colors.grey[600])),
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
