import 'package:equatable/equatable.dart';

abstract class BestStoriesEvent extends Equatable {
  const BestStoriesEvent();
}

class FetchBestStoriesEvent extends BestStoriesEvent {
  @override
  List<Object> get props => [];
}
