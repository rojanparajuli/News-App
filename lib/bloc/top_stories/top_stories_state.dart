import 'package:equatable/equatable.dart';
import 'package:news/model/top_stories_data.dart';

abstract class TopStoriesState extends Equatable {
  const TopStoriesState();

  @override
  List<Object?> get props => [];
}

class TopStoriesInitial extends TopStoriesState {}

class TopStoriesLoading extends TopStoriesState {}

class TopStoriesLoaded extends TopStoriesState {
  final List<TopStoriesData> data;
  

   const TopStoriesLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class TopStoriesError extends TopStoriesState {
  final String message;

  const TopStoriesError(this.message);

  @override
  List<Object?> get props => [message];
}


class ItemDataFetched extends TopStoriesState {
  final TopStoriesData data;

  const ItemDataFetched(this.data);

  @override
  List<Object?> get props=> [data];


}

class ItemDataFetchError extends TopStoriesState {
  final String message;

  const ItemDataFetchError(this.message);

  @override
  List<Object?> get props=> [message];


}
