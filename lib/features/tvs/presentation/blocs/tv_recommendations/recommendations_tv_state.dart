part of 'recommendations_tv_bloc.dart';

abstract class RecommendationsTvState extends Equatable {
  const RecommendationsTvState();

  @override
  List<Object> get props => [];
}

class RecommendationsTvStateEmpty extends RecommendationsTvState {}

class RecommendationsTvStateLoading extends RecommendationsTvState {}

class RecommendationsTvStateLoaded extends RecommendationsTvState {
  final List<TV> recomendation;
  RecommendationsTvStateLoaded(this.recomendation);
}

class RecommendationsTvStateError extends RecommendationsTvState {
  final String message;
  RecommendationsTvStateError(this.message);
}
