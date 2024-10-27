import 'package:equatable/equatable.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object?> get props => [];
}

class CommentStateInitial extends CommentState {}

class CommentStateLoading extends CommentState {}

class CommentStateLoaded extends CommentState {
  const CommentStateLoaded();

  @override
  List<Object?> get props => [];
}

class CommentStateError extends CommentState {
  final String message;

  const CommentStateError(this.message);

  @override
  List<Object?> get props => [message];
}
