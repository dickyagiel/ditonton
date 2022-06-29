import 'package:ditonton/features/tvs/presentation/blocs/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/popular_tv/popular_tv_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/top_rated_tv/top_rate_tv_bloc.dart';
import 'package:ditonton/features/tvs/presentation/pages/home_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../dummy_data/dummy_objects.dart';

class MockPopularTvBloc extends Mock implements PopularTvBloc {}

class FakePopularEvent extends Fake implements PopularTvEvent {}

class FakePopularState extends Fake implements PopularTvState {}

class MockTopRatedTvBloc extends Mock implements TopRateTvBloc {}

class FakeTopRatedEvent extends Fake implements TopRateTvEvent {}

class FakeTopRatedState extends Fake implements TopRateTvState {}

class MockNowPlayingTvBloc extends Mock implements NowPlayingTvBloc {}

class NowPlayingtvStateFake extends Fake implements NowPlayingTvState {}

class NowPlayingtvEventFake extends Fake implements NowPlayingTvEvent {}

void main() {
  late MockPopularTvBloc mockPopularTvBloc;
  late MockNowPlayingTvBloc mockNowPlayingTvBloc;
  late MockTopRatedTvBloc mockTopRateTvBloc;

  setUpAll(() {
    registerFallbackValue(FakePopularEvent());
    registerFallbackValue(FakePopularState());
    registerFallbackValue(FakeTopRatedEvent());
    registerFallbackValue(FakeTopRatedState());
    registerFallbackValue(NowPlayingtvStateFake());
    registerFallbackValue(NowPlayingtvEventFake());
  });

  setUp(() {
    mockPopularTvBloc = MockPopularTvBloc();
    mockNowPlayingTvBloc = MockNowPlayingTvBloc();
    mockTopRateTvBloc = MockTopRatedTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularTvBloc>.value(value: mockPopularTvBloc),
        BlocProvider<NowPlayingTvBloc>.value(value: mockNowPlayingTvBloc),
        BlocProvider<TopRateTvBloc>.value(value: mockTopRateTvBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display progress bar when loading",
    (WidgetTester tester) async {
      //popular
      when(() => mockPopularTvBloc.stream)
          .thenAnswer(((_) => Stream.value(PopularTvStateLoading())));
      when(() => mockPopularTvBloc.state).thenReturn(PopularTvStateLoading());
      //now playing
      when(() => mockNowPlayingTvBloc.stream)
          .thenAnswer((_) => Stream.value(NowPlayingStateLoading()));
      when(() => mockNowPlayingTvBloc.state)
          .thenReturn(NowPlayingStateLoading());
      //top rated
      when(() => mockTopRateTvBloc.stream)
          .thenAnswer((_) => Stream.value(TopRateTvStateLoading()));
      when(() => mockTopRateTvBloc.state).thenReturn(TopRateTvStateLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(HomeTVPage()));

      expect(progressFinder, findsNWidgets(3));
      expect(centerFinder, findsWidgets);
    },
  );

  testWidgets(
    "Page should display ListView when data is loaded",
    (WidgetTester tester) async {
      when(() => mockPopularTvBloc.stream)
          .thenAnswer(((_) => Stream.value(PopularTvStateLoaded(testTVList))));
      when(() => mockPopularTvBloc.state)
          .thenReturn(PopularTvStateLoaded(testTVList));
      //now playing
      when(() => mockNowPlayingTvBloc.stream)
          .thenAnswer((_) => Stream.value(NowPlayingStateLoaded(testTVList)));
      when(() => mockNowPlayingTvBloc.state)
          .thenReturn(NowPlayingStateLoaded(testTVList));
      //top rated
      when(() => mockTopRateTvBloc.stream)
          .thenAnswer((_) => Stream.value(TopRateTvStateLoaded(testTVList)));
      when(() => mockTopRateTvBloc.state)
          .thenReturn(TopRateTvStateLoaded(testTVList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(HomeTVPage()));

      expect(listViewFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    "Page should display text with message when Error",
    (WidgetTester tester) async {
      when(() => mockPopularTvBloc.stream)
          .thenAnswer(((_) => Stream.value(PopularTvStateError(tError))));
      when(() => mockPopularTvBloc.state)
          .thenReturn(PopularTvStateError(tError));
      //now playing
      when(() => mockNowPlayingTvBloc.stream)
          .thenAnswer((_) => Stream.value(NowPlayingStateError(tError)));
      when(() => mockNowPlayingTvBloc.state)
          .thenReturn(NowPlayingStateError(tError));
      //top rated
      when(() => mockTopRateTvBloc.stream)
          .thenAnswer((_) => Stream.value(TopRateTvStateError(tError)));
      when(() => mockTopRateTvBloc.state)
          .thenReturn(TopRateTvStateError(tError));

      final textFinder = find.text("Failed");

      await tester.pumpWidget(_makeTestableWidget(HomeTVPage()));

      expect(textFinder, findsNWidgets(3));
    },
  );
}
