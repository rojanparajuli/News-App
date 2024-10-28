import 'package:equatable/equatable.dart';

abstract class NewStoriesEvent extends Equatable {
  const NewStoriesEvent();
}

class FetchLatestNews extends NewStoriesEvent {
  @override
  List<Object> get props => [];
}
