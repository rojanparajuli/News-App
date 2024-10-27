import 'package:equatable/equatable.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();
}

class FetchCommentEvent extends CommentEvent {
  @override
  List<Object> get props => [];
}
