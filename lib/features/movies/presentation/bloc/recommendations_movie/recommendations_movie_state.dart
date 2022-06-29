part of 'recommendations_movie_bloc.dart';

abstract class RecommendationsMovieState extends Equatable {
  const RecommendationsMovieState();

  @override
  List<Object> get props => [];
}

class RecommendationsMovieInitial extends RecommendationsMovieState {}

class RecommendationsMovieLoading extends RecommendationsMovieState {}

class RecommendationsMovieLoaded extends RecommendationsMovieState {
  final List<Movie> result;

  RecommendationsMovieLoaded(this.result);
}

class RecommendationsMovieError extends RecommendationsMovieState {
  final String message;

  RecommendationsMovieError(this.message);
}
