import 'package:equatable/equatable.dart';

abstract class BestStoriesState extends Equatable {
  const BestStoriesState();

  @override
  List<Object?> get props => [];
}

class BestStoriesStateInitial extends BestStoriesState {}

class BestStoriesStateLoading extends BestStoriesState {}

class BestStoriesStateLoaded extends BestStoriesState {
  const BestStoriesStateLoaded();

  @override
  List<Object?> get props => [];
}

class BestStoriesStateError extends BestStoriesState {
  final String message;

  const BestStoriesStateError(this.message);

  @override
  List<Object?> get props => [message];
}
