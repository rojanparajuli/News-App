import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/best_stories/best_stories_state.dart';
import 'package:news/service/best_stories/best_stories_service.dart';

class BestStoriesCubit extends Cubit<BestStoriesState> {
  final BestStoriesService bestStoriesService;
  static const int _initialFetchLimit = 100;
  BestStoriesCubit(this.bestStoriesService) : super(BestStoriesStateInitial());

  void fetchbeststories({int limit = _initialFetchLimit}) async {
    try {
      emit(BestStoriesStateLoading());

      final topStories = await bestStoriesService.fetchbeststories();

      final limitedStories = topStories.take(limit);
      limitedStories.map((e) {
        return bestStoriesService.fetchItemData(e);
      });

      emit(const BestStoriesStateLoaded());
    } catch (e) {
      emit(BestStoriesStateError(e.toString()));
    }
  }

  getData(int id) {
    return bestStoriesService.fetchItemData(id);
  }
}
