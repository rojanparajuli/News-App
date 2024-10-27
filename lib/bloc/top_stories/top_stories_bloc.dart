import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/top_stories/top_stories_state.dart';
import 'package:news/service/top_stories_service.dart';

class HackerNewsCubit extends Cubit<TopStoriesState> {
  final NewsDataService hackerNewsService;

  HackerNewsCubit(this.hackerNewsService) : super(TopStoriesInitial());

  void fetchTopStories() async {
    try {
      emit(TopStoriesLoading());

      final topStories = await hackerNewsService.fetchLatestNews();

      final toStoriesData = topStories.map((e) {
        return hackerNewsService.fetchItemData(e);
      });

      final data = await Future.wait(toStoriesData);

      emit(TopStoriesLoaded(data));
    } catch (e) {
      emit(TopStoriesError(e.toString()));
    }
  }

  getData(int id) {
    return hackerNewsService.fetchItemData(id);
  }
}
