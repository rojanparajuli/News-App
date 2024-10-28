import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/new_stories/new_stories_state.dart';
import 'package:news/service/new_stories/new_stories_service.dart';

class NewStoriesCubit extends Cubit<NewStoriesState> {
  final NewStoriesService newStoriesService;
  static const int _initialFetchLimit = 100;
  NewStoriesCubit(this.newStoriesService) : super(NewStoriesStateInitial());

 void fetchnewstories({int limit = _initialFetchLimit}) async {
  try {
    emit(NewStoriesStateLoading());

    final topStories = await newStoriesService.fetchnewstories();
    final limitedStories = topStories.take(limit).toList();

    emit(NewStoriesStateLoaded(limitedStories));
  } catch (e) {
    emit(NewStoriesStateError(e.toString()));
  }
}


  getData(int id) {
    return newStoriesService.fetchItemData(id);
  }
}
