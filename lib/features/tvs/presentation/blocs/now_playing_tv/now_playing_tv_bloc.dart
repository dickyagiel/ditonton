import 'package:bloc/bloc.dart';
import 'package:ditonton/features/tvs/domain/entities/tv.dart';
import 'package:ditonton/features/tvs/domain/usecases/get_now_playing_tv.dart';
import 'package:equatable/equatable.dart';
part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  final GetNowPlayingTV getNowPlayingTv;
  NowPlayingTvBloc({required this.getNowPlayingTv})
      : super(NowPlayingStateEmpty()) {
    on<NowPlayingTvEvent>((event, emit) async {
      emit(NowPlayingStateLoading());
      final result = await getNowPlayingTv.execute();
      result.fold(
        (failure) => emit(NowPlayingStateError(failure.message)),
        (result) => emit(NowPlayingStateLoaded(result)),
      );
    });
  }
}
