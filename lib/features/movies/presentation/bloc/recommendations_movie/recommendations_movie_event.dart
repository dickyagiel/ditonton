part of 'recommendations_movie_bloc.dart';

abstract class RecommendationsMovieEvent extends Equatable {
  const RecommendationsMovieEvent();

  @override
  List<Object> get props => [];
}

class GetRecommendationsMovieEvent extends RecommendationsMovieEvent {
  final int id;

  GetRecommendationsMovieEvent(this.id);
}
