import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movies/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/features/movies/presentation/bloc/recommendations_movie/recommendations_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../dummy_data/dummy_objects.dart';
import 'recommendations_movie_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations usecase;
  late RecommendationsMovieBloc bloc;

  setUp(() {
    usecase = MockGetMovieRecommendations();
    bloc = RecommendationsMovieBloc(usecase: usecase);
  });

  test('initial state should be empty', () {
    expect(bloc.state, RecommendationsMovieInitial());
  });

  blocTest<RecommendationsMovieBloc, RecommendationsMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute(tId)).thenAnswer((_) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetRecommendationsMovieEvent(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      RecommendationsMovieLoading(),
      RecommendationsMovieLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId));
    },
  );

  blocTest<RecommendationsMovieBloc, RecommendationsMovieState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetRecommendationsMovieEvent(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      RecommendationsMovieLoading(),
      RecommendationsMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId));
    },
  );
}
