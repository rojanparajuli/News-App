import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/top_stories/top_stories_state.dart';
import 'package:news/service/top_stories/top_stories_service.dart';

class HackerNewsCubit extends Cubit<TopStoriesState> {
  final NewsDataService hackerNewsService;
  static const int _initialFetchLimit = 100; 
  HackerNewsCubit(this.hackerNewsService) : super(TopStoriesInitial());

  void fetchTopStories({int limit = _initialFetchLimit}) async {
    try {
      emit(TopStoriesLoading());

      final topStories = await hackerNewsService.fetchLatestNews();

      final limitedStories = topStories.take(limit);
      final toStoriesData = limitedStories.map((e) {
        return hackerNewsService.fetchItemData(e);
      });

      print('jhkkkkk $toStoriesData');

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
