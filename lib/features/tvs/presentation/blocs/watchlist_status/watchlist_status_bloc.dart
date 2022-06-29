import 'package:bloc/bloc.dart';
import 'package:ditonton/features/tvs/domain/usecases/get_watchlist_status_tv.dart';
import 'package:equatable/equatable.dart';
part 'watchlist_status_event.dart';
part 'watchlist_status_state.dart';

class WatchlistStatusBloc
    extends Bloc<WatchlistStatusEvent, WatchlistStatusState> {
  final GetWatchListStatusTV getWatchlistTVStatus;
  WatchlistStatusBloc({required this.getWatchlistTVStatus})
      : super(WatchlistStatusInitial()) {
    on<WatchlistStatus>((event, emit) async {
      final result = await getWatchlistTVStatus.execute(event.id);
      if (result) {
        emit(WatchlistStatusTrue());
      } else {
        emit(WatchlistStatusFalse());
      }
    });
  }
}
