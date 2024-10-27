import 'package:equatable/equatable.dart';

abstract class TopStoriesEvent extends Equatable {
  const TopStoriesEvent();
}

class FetchTopStories extends TopStoriesEvent {
  @override
  List<Object> get props => [];
}
