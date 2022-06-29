part of 'recommendations_tv_bloc.dart';

abstract class RecommendationsTvEvent extends Equatable {
  const RecommendationsTvEvent();

  @override
  List<Object> get props => [];
}

class RecommendationsTv extends RecommendationsTvEvent {
  final int id;

  RecommendationsTv(this.id);
}
