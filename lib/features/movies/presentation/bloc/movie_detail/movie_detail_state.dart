part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail result;

  MovieDetailLoaded(this.result);
}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);
}
