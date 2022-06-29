import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movies/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/features/movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MockGetMovieDetail usecase;
  late MovieDetailBloc bloc;

  setUp(() {
    usecase = MockGetMovieDetail();
    bloc = MovieDetailBloc(usecase: usecase);
  });

  test('initial state should be empty', () {
    expect(bloc.state, MovieDetailInitial());
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      return bloc;
    },
    act: (bloc) => bloc.add(GetMovieDetailEvent(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailLoaded(testMovieDetail),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetMovieDetailEvent(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId));
    },
  );
}
