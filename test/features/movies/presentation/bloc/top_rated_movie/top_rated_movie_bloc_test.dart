import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movies/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/features/movies/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../dummy_data/dummy_objects.dart';
import 'top_rated_movie_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies usecase;
  late TopRatedMovieBloc bloc;

  setUp(() {
    usecase = MockGetTopRatedMovies();
    bloc = TopRatedMovieBloc(usecase: usecase);
  });

  test('initial state should be empty', () {
    expect(bloc.state, TopRatedMovieInitial());
  });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetTopRatedMovieEvent()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
    },
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetTopRatedMovieEvent()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(usecase.execute());
    },
  );
}
