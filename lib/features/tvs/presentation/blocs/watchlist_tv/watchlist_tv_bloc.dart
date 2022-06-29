import 'package:bloc/bloc.dart';
import 'package:ditonton/features/tvs/domain/entities/tv.dart';
import 'package:ditonton/features/tvs/domain/usecases/get_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTV getWatchListTv;
  WatchlistTvBloc({required this.getWatchListTv})
      : super(WatchlistTvStateEmpty()) {
    on<WatchlistTvEvent>((event, emit) async {
      emit(WatchlistTvStateLoading());
      final result = await getWatchListTv.execute();
      result.fold(
        (failure) => emit(WatchlistTvStateError(failure.message)),
        (result) => emit(WatchlistTvStateLoaded(result)),
      );
    });
  }
}
