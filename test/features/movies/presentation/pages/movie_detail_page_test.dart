import 'package:ditonton/features/movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/recommendations_movie/recommendations_movie_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/watchlist_movie_event/watchlist_movie_event_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/watchlist_movie_status/watchlist_movie_status_bloc.dart';
import 'package:ditonton/features/movies/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends Mock implements MovieDetailBloc {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MockWatchlistEventBloc extends Mock implements WatchlistMovieEventBloc {}

class WatchlistEventStateFake extends Fake implements WatchlistMovieEventState {
}

class WatchlistEventEventFake extends Fake implements WatchlistMovieEventEvent {
}

class MockWatchlistStatusBloc extends Mock implements WatchlistMovieStatusBloc {
}

class WatchlistStatusEventFake extends Fake
    implements WatchlistMovieStatusEvent {}

class WatchlistStatusStateFake extends Fake
    implements WatchlistMovieStatusState {}

class MockRecommendationsMovieBloc extends Mock
    implements RecommendationsMovieBloc {}

class RecommendationsMovieStateFake extends Fake
    implements RecommendationsMovieState {}

class RecommendationsMovieEventFake extends Fake
    implements RecommendationsMovieEvent {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockWatchlistEventBloc mockWatchlistEventBloc;
  late MockWatchlistStatusBloc mockWatchlistStatusBloc;
  late MockRecommendationsMovieBloc mockRecommendationsMovieBloc;

  setUpAll(() {
    registerFallbackValue(MovieDetailStateFake());
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(WatchlistStatusEventFake());
    registerFallbackValue(WatchlistStatusStateFake());
    registerFallbackValue(WatchlistEventEventFake());
    registerFallbackValue(WatchlistEventStateFake());
    registerFallbackValue(RecommendationsMovieStateFake());
    registerFallbackValue(RecommendationsMovieEventFake());
  });

  setUp(() {
    mockWatchlistStatusBloc = MockWatchlistStatusBloc();
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockWatchlistEventBloc = MockWatchlistEventBloc();
    mockRecommendationsMovieBloc = MockRecommendationsMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>.value(value: mockMovieDetailBloc),
        BlocProvider<WatchlistMovieEventBloc>.value(
            value: mockWatchlistEventBloc),
        BlocProvider<WatchlistMovieStatusBloc>.value(
            value: mockWatchlistStatusBloc),
        BlocProvider<RecommendationsMovieBloc>.value(
            value: mockRecommendationsMovieBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display progress bar when loading",
    (WidgetTester tester) async {
      //tv detail
      when(() => mockMovieDetailBloc.stream)
          .thenAnswer(((_) => Stream.value(MovieDetailLoading())));
      when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoading());
      //watchlist event
      when(() => mockWatchlistEventBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistMovieEventInitial())));
      when(() => mockWatchlistEventBloc.state)
          .thenReturn(WatchlistMovieEventInitial());
      //watchlist status
      when(() => mockWatchlistStatusBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistMovieStatusInitial())));
      when(() => mockWatchlistStatusBloc.state)
          .thenReturn(WatchlistMovieStatusInitial());
      //Recommendations
      when(() => mockRecommendationsMovieBloc.stream)
          .thenAnswer(((_) => Stream.value(RecommendationsMovieLoading())));
      when(() => mockRecommendationsMovieBloc.state)
          .thenReturn(RecommendationsMovieLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);
      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

      expect(progressFinder, findsOneWidget);
      expect(centerFinder, findsWidgets);
    },
  );

  // testWidgets(
  //   "display poster as background",
  //   (WidgetTester tester) async {
  //     //tv detail
  //     when(() => mockMovieDetailBloc.stream).thenAnswer(
  //         ((_) => Stream.value(MovieDetailLoaded(testMovieDetail))));
  //     when(() => mockMovieDetailBloc.state)
  //         .thenReturn(MovieDetailLoaded(testMovieDetail));
  //     //watchlist event
  //     when(() => mockWatchlistEventBloc.stream)
  //         .thenAnswer(((_) => Stream.value(WatchlistMovieEventInitial())));
  //     when(() => mockWatchlistEventBloc.state)
  //         .thenReturn(WatchlistMovieEventInitial());
  //     //watchlist status
  //     when(() => mockWatchlistStatusBloc.stream)
  //         .thenAnswer(((_) => Stream.value(WatchlistMovieStatusTrue())));
  //     when(() => mockWatchlistStatusBloc.state)
  //         .thenReturn(WatchlistMovieStatusTrue());
  //     //Recommendations
  //     when(() => mockRecommendationsMovieBloc.stream).thenAnswer(
  //         ((_) => Stream.value(RecommendationsMovieLoaded(testMovieList))));
  //     when(() => mockRecommendationsMovieBloc.state)
  //         .thenReturn(RecommendationsMovieLoaded(testMovieList));

  //     final watchlistButtonIcon = find.byKey(Key("background_image"));

  //     await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

  //     expect(watchlistButtonIcon, findsOneWidget);
  //   },
  // );

  testWidgets(
    "Watchlist button should display check icon when tv is added to watchlist",
    (WidgetTester tester) async {
      //tv detail
      when(() => mockMovieDetailBloc.stream).thenAnswer(
          ((_) => Stream.value(MovieDetailLoaded(testMovieDetail))));
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailLoaded(testMovieDetail));
      //watchlist event
      when(() => mockWatchlistEventBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistMovieEventInitial())));
      when(() => mockWatchlistEventBloc.state)
          .thenReturn(WatchlistMovieEventInitial());
      //watchlist status
      when(() => mockWatchlistStatusBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistMovieStatusTrue())));
      when(() => mockWatchlistStatusBloc.state)
          .thenReturn(WatchlistMovieStatusTrue());
      //Recommendations
      when(() => mockRecommendationsMovieBloc.stream).thenAnswer(
          ((_) => Stream.value(RecommendationsMovieLoaded(testMovieList))));
      when(() => mockRecommendationsMovieBloc.state)
          .thenReturn(RecommendationsMovieLoaded(testMovieList));

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    "Watchlist button should display add icon when tv not added to watchlist",
    (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.stream).thenAnswer(
          ((_) => Stream.value(MovieDetailLoaded(testMovieDetail))));
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailLoaded(testMovieDetail));
      //watchlist event
      when(() => mockWatchlistEventBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistMovieEventInitial())));
      when(() => mockWatchlistEventBloc.state)
          .thenReturn(WatchlistMovieEventInitial());
      //watchlist status
      when(() => mockWatchlistStatusBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistMovieStatusFalse())));
      when(() => mockWatchlistStatusBloc.state)
          .thenReturn(WatchlistMovieStatusFalse());
      //Recommendations
      when(() => mockRecommendationsMovieBloc.stream).thenAnswer(
          ((_) => Stream.value(RecommendationsMovieLoaded(testMovieList))));
      when(() => mockRecommendationsMovieBloc.state)
          .thenReturn(RecommendationsMovieLoaded(testMovieList));

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    "Watchlist button should display Snackbar when added to watchlist",
    (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.stream).thenAnswer(
          ((_) => Stream.value(MovieDetailLoaded(testMovieDetail))));
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailLoaded(testMovieDetail));
      //watchlist event
      when(() => mockWatchlistEventBloc.stream).thenAnswer(((_) =>
          Stream.value(WatchlistMovieEventLoaded('Added to Watchlist'))));
      when(() => mockWatchlistEventBloc.state)
          .thenReturn(WatchlistMovieEventLoaded('Added to Watchlist'));
      //watchlist status
      when(() => mockWatchlistStatusBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistMovieStatusFalse())));
      when(() => mockWatchlistStatusBloc.state)
          .thenReturn(WatchlistMovieStatusFalse());
      //Recommendations
      when(() => mockRecommendationsMovieBloc.stream).thenAnswer(
          ((_) => Stream.value(RecommendationsMovieLoaded(testMovieList))));
      when(() => mockRecommendationsMovieBloc.state)
          .thenReturn(RecommendationsMovieLoaded(testMovieList));

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    },
  );

  testWidgets(
    "Display rating of tv Show",
    (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.stream).thenAnswer(
          ((_) => Stream.value(MovieDetailLoaded(testMovieDetail))));
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailLoaded(testMovieDetail));
      //watchlist event
      when(() => mockWatchlistEventBloc.stream).thenAnswer(
          ((_) => Stream.value(WatchlistMovieEventLoaded('Failed'))));
      when(() => mockWatchlistEventBloc.state)
          .thenReturn(WatchlistMovieEventLoaded('Failed'));
      //watchlist status
      when(() => mockWatchlistStatusBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistMovieStatusFalse())));
      when(() => mockWatchlistStatusBloc.state)
          .thenReturn(WatchlistMovieStatusFalse());
      //Recommendations
      when(() => mockRecommendationsMovieBloc.stream).thenAnswer(
          ((_) => Stream.value(RecommendationsMovieLoaded(testMovieList))));
      when(() => mockRecommendationsMovieBloc.state)
          .thenReturn(RecommendationsMovieLoaded(testMovieList));

      final ratingFinder = find.byType(RatingBarIndicator);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

      expect(ratingFinder, findsOneWidget);
    },
  );

  // testWidgets(
  //   "Display genres of Movie Show",
  //   (WidgetTester tester) async {
  //     when(() => mockMovieDetailBloc.stream).thenAnswer(
  //         ((_) => Stream.value(MovieDetailLoaded(testMovieDetail))));
  //     when(() => mockMovieDetailBloc.state)
  //         .thenReturn(MovieDetailLoaded(testMovieDetail));
  //     //watchlist event
  //     when(() => mockWatchlistEventBloc.stream).thenAnswer(
  //         ((_) => Stream.value(WatchlistMovieEventLoaded('Failed'))));
  //     when(() => mockWatchlistEventBloc.state)
  //         .thenReturn(WatchlistMovieEventLoaded('Failed'));
  //     //watchlist status
  //     when(() => mockWatchlistStatusBloc.stream)
  //         .thenAnswer(((_) => Stream.value(WatchlistMovieStatusFalse())));
  //     when(() => mockWatchlistStatusBloc.state)
  //         .thenReturn(WatchlistMovieStatusFalse());
  //     //Recommendations
  //     when(() => mockRecommendationsMovieBloc.stream).thenAnswer(
  //         ((_) => Stream.value(RecommendationsMovieLoaded(testMovieList))));
  //     when(() => mockRecommendationsMovieBloc.state)
  //         .thenReturn(RecommendationsMovieLoaded(testMovieList));

  //     final genreFinder = find.byKey(Key("Genres"));

  //     await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

  //     expect(genreFinder, findsOneWidget);
  //   },
  // );

  // testWidgets(
  //   "Display duration of Movie",
  //   (WidgetTester tester) async {
  //     when(() => mockMovieDetailBloc.stream).thenAnswer(
  //         ((_) => Stream.value(MovieDetailLoaded(testMovieDetail))));
  //     when(() => mockMovieDetailBloc.state)
  //         .thenReturn(MovieDetailLoaded(testMovieDetail));
  //     //watchlist event
  //     when(() => mockWatchlistEventBloc.stream).thenAnswer(
  //         ((_) => Stream.value(WatchlistMovieEventLoaded('Failed'))));
  //     when(() => mockWatchlistEventBloc.state)
  //         .thenReturn(WatchlistMovieEventLoaded('Failed'));
  //     //watchlist status
  //     when(() => mockWatchlistStatusBloc.stream)
  //         .thenAnswer(((_) => Stream.value(WatchlistMovieStatusFalse())));
  //     when(() => mockWatchlistStatusBloc.state)
  //         .thenReturn(WatchlistMovieStatusFalse());
  //     //Recommendations
  //     when(() => mockRecommendationsMovieBloc.stream).thenAnswer(
  //         ((_) => Stream.value(RecommendationsMovieLoaded(testMovieList))));
  //     when(() => mockRecommendationsMovieBloc.state)
  //         .thenReturn(RecommendationsMovieLoaded(testMovieList));

  //     final durationFinder = find.byKey(Key("Duration"));

  //     await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

  //     expect(durationFinder, findsOneWidget);
  //   },
  // );
}
