import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movies/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/features/movies/domain/usecases/save_watchlist.dart';
import 'package:ditonton/features/movies/presentation/bloc/watchlist_movie_event/watchlist_movie_event_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_event_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlist, RemoveWatchlist])
void main() {
  late MockSaveWatchlist saveWatchlist;
  late MockRemoveWatchlist removeWatchlist;
  late WatchlistMovieEventBloc bloc;

  setUp(() {
    saveWatchlist = MockSaveWatchlist();
    removeWatchlist = MockRemoveWatchlist();
    bloc = WatchlistMovieEventBloc(
      saveWatchlist: saveWatchlist,
      removeWatchlist: removeWatchlist,
    );
  });

  test('initial state should be empty', () {
    expect(bloc.state, WatchlistMovieEventInitial());
  });

  group(
    'saveWatchListTv test',
    () {
      blocTest<WatchlistMovieEventBloc, WatchlistMovieEventState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(saveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Added to Watchlist'));
          return bloc;
        },
        act: (bloc) => bloc.add(AddWatchlistMovie(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          WatchlistMovieEventLoading(),
          WatchlistMovieEventLoaded('Added to Watchlist'),
        ],
        verify: (bloc) {
          verify(saveWatchlist.execute(testMovieDetail));
        },
      );

      blocTest<WatchlistMovieEventBloc, WatchlistMovieEventState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(saveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return bloc;
        },
        act: (bloc) => bloc.add(AddWatchlistMovie(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          WatchlistMovieEventLoading(),
          WatchlistMovieEventError('Server Failure'),
        ],
        verify: (bloc) {
          verify(saveWatchlist.execute(testMovieDetail));
        },
      );
    },
  );

  group(
    'removeWatchListTv test',
    () {
      blocTest<WatchlistMovieEventBloc, WatchlistMovieEventState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(removeWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Removed from Watchlist'));
          return bloc;
        },
        act: (bloc) => bloc.add(RemoveWatchlistMovie(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          WatchlistMovieEventLoading(),
          WatchlistMovieEventLoaded('Removed from Watchlist'),
        ],
        verify: (bloc) {
          verify(removeWatchlist.execute(testMovieDetail));
        },
      );

      blocTest<WatchlistMovieEventBloc, WatchlistMovieEventState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(removeWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return bloc;
        },
        act: (bloc) => bloc.add(RemoveWatchlistMovie(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          WatchlistMovieEventLoading(),
          WatchlistMovieEventError('Server Failure'),
        ],
        verify: (bloc) {
          verify(removeWatchlist.execute(testMovieDetail));
        },
      );
    },
  );
}
