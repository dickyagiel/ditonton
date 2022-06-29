part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class TvDetail extends TvDetailEvent {
  final int id;
  TvDetail(this.id);
}
