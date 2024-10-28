import 'package:equatable/equatable.dart';

abstract class NewStoriesState extends Equatable {
  const NewStoriesState();

  @override
  List<Object?> get props => [];
}

class NewStoriesStateInitial extends NewStoriesState {}

class NewStoriesStateLoading extends NewStoriesState {}

class NewStoriesStateLoaded extends NewStoriesState {
  final List<int> storyIds;

  const NewStoriesStateLoaded(this.storyIds);

  @override
  List<Object?> get props => [storyIds];
}


class NewStoriesStateError extends NewStoriesState {
  final String message;

  const NewStoriesStateError(this.message);

  @override
  List<Object?> get props => [message];
}

