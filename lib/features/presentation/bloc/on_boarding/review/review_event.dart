import '../../base_event.dart';

abstract class ReviewEvent extends BaseEvent {}

/// Get Review Info
class GetReviewInfoEvent extends ReviewEvent {}

class SaveReviewEvent extends ReviewEvent {}
