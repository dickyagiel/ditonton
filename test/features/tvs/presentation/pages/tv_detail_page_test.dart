import 'package:ditonton/features/tvs/presentation/blocs/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/tv_recommendations/recommendations_tv_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/watchlist_event/watchlist_event_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/watchlist_status/watchlist_status_bloc.dart';
import 'package:ditonton/features/tvs/presentation/pages/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../dummy_data/dummy_objects.dart';

class MockTvDetailBloc extends Mock implements TvDetailBloc {}

class TvDetailStateFake extends Fake implements TvDetailState {}

class TvDetailEventFake extends Fake implements TvDetailEvent {}

class MockWatchlistEventBloc extends Mock implements WatchlistEventBloc {}

class WatchlistEventFake extends Fake implements WatchlistEventEvent {}

class WatchlistStateFake extends Fake implements WatchlistEventState {}

class MockWatchlistStatusBloc extends Mock implements WatchlistStatusBloc {}

class WatchlistStatusEventFake extends Fake implements WatchlistStatusEvent {}

class WatchlistStatusStateFake extends Fake implements WatchlistStatusState {}

class MockRecommendationsTvBloc extends Mock implements RecommendationsTvBloc {}

class RecommendationsTvStateFake extends Fake
    implements RecommendationsTvState {}

class RecommendationsTvEventFake extends Fake
    implements RecommendationsTvEvent {}

void main() {
  late MockWatchlistEventBloc mockWatchlistEventBloc;
  late MockTvDetailBloc mockTvDetailBloc;
  late MockWatchlistStatusBloc mockWatchlistStatusBloc;
  late MockRecommendationsTvBloc mockRecommendationsTvBloc;

  setUpAll(() {
    registerFallbackValue(TvDetailStateFake());
    registerFallbackValue(TvDetailEventFake());
    registerFallbackValue(WatchlistEventFake());
    registerFallbackValue(WatchlistStateFake());
    registerFallbackValue(WatchlistStatusEventFake());
    registerFallbackValue(WatchlistStatusStateFake());
    registerFallbackValue(RecommendationsTvEventFake());
    registerFallbackValue(RecommendationsTvStateFake());
  });

  setUp(() {
    mockWatchlistStatusBloc = MockWatchlistStatusBloc();
    mockTvDetailBloc = MockTvDetailBloc();
    mockWatchlistEventBloc = MockWatchlistEventBloc();
    mockRecommendationsTvBloc = MockRecommendationsTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>.value(value: mockTvDetailBloc),
        BlocProvider<WatchlistEventBloc>.value(value: mockWatchlistEventBloc),
        BlocProvider<WatchlistStatusBloc>.value(value: mockWatchlistStatusBloc),
        BlocProvider<RecommendationsTvBloc>.value(
            value: mockRecommendationsTvBloc),
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
      when(() => mockTvDetailBloc.stream)
          .thenAnswer(((_) => Stream.value(TvDetailStateLoading())));
      when(() => mockTvDetailBloc.state).thenReturn(TvDetailStateLoading());
      //watchlist event
      when(() => mockWatchlistEventBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistEventStateEmpty())));
      when(() => mockWatchlistEventBloc.state)
          .thenReturn(WatchlistEventStateEmpty());
      //watchlist status
      when(() => mockWatchlistStatusBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistStatusInitial())));
      when(() => mockWatchlistStatusBloc.state)
          .thenReturn(WatchlistStatusInitial());
      //recommendations
      when(() => mockRecommendationsTvBloc.stream)
          .thenAnswer(((_) => Stream.value(RecommendationsTvStateLoading())));
      when(() => mockRecommendationsTvBloc.state)
          .thenReturn(RecommendationsTvStateLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);
      await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: tId)));

      expect(progressFinder, findsOneWidget);
      expect(centerFinder, findsWidgets);
    },
  );

  // testWidgets(
  //   "display poster as background",
  //   (WidgetTester tester) async {
  //     //tv detail
  //     when(() => mockTvDetailBloc.stream)
  //         .thenAnswer(((_) => Stream.value(TvDetailStateLoaded(testTVDetail))));
  //     when(() => mockTvDetailBloc.state)
  //         .thenReturn(TvDetailStateLoaded(testTVDetail));
  //     //watchlist event
  //     when(() => mockWatchlistEventBloc.stream)
  //         .thenAnswer(((_) => Stream.value(WatchlistEventStateEmpty())));
  //     when(() => mockWatchlistEventBloc.state)
  //         .thenReturn(WatchlistEventStateEmpty());
  //     //watchlist status
  //     when(() => mockWatchlistStatusBloc.stream)
  //         .thenAnswer(((_) => Stream.value(WatchlistStatusTrue())));
  //     when(() => mockWatchlistStatusBloc.state)
  //         .thenReturn(WatchlistStatusTrue());
  //     //recommendations
  //     when(() => mockRecommendationsTvBloc.stream).thenAnswer(
  //         ((_) => Stream.value(RecommendationsTvStateLoaded(testTVList))));
  //     when(() => mockRecommendationsTvBloc.state)
  //         .thenReturn(RecommendationsTvStateLoaded(testTVList));

  //     final watchlistButtonIcon = find.byKey(Key("background_image"));

  //     await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

  //     expect(watchlistButtonIcon, findsOneWidget);
  //   },
  // );

  testWidgets(
    "Watchlist button should display check icon when tv is added to watchlist",
    (WidgetTester tester) async {
      //tv detail
      when(() => mockTvDetailBloc.stream)
          .thenAnswer(((_) => Stream.value(TvDetailStateLoaded(testTVDetail))));
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailStateLoaded(testTVDetail));
      //watchlist event
      when(() => mockWatchlistEventBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistEventStateEmpty())));
      when(() => mockWatchlistEventBloc.state)
          .thenReturn(WatchlistEventStateEmpty());
      //watchlist status
      when(() => mockWatchlistStatusBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistStatusTrue())));
      when(() => mockWatchlistStatusBloc.state)
          .thenReturn(WatchlistStatusTrue());
      //recommendations
      when(() => mockRecommendationsTvBloc.stream).thenAnswer(
          ((_) => Stream.value(RecommendationsTvStateLoaded(testTVList))));
      when(() => mockRecommendationsTvBloc.state)
          .thenReturn(RecommendationsTvStateLoaded(testTVList));

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    "Watchlist button should display add icon when tv not added to watchlist",
    (WidgetTester tester) async {
      when(() => mockTvDetailBloc.stream)
          .thenAnswer(((_) => Stream.value(TvDetailStateLoaded(testTVDetail))));
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailStateLoaded(testTVDetail));
      //watchlist event
      when(() => mockWatchlistEventBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistEventStateEmpty())));
      when(() => mockWatchlistEventBloc.state)
          .thenReturn(WatchlistEventStateEmpty());
      //watchlist status
      when(() => mockWatchlistStatusBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistStatusFalse())));
      when(() => mockWatchlistStatusBloc.state)
          .thenReturn(WatchlistStatusFalse());
      //recommendations
      when(() => mockRecommendationsTvBloc.stream).thenAnswer(
          ((_) => Stream.value(RecommendationsTvStateLoaded(testTVList))));
      when(() => mockRecommendationsTvBloc.state)
          .thenReturn(RecommendationsTvStateLoaded(testTVList));

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    "Watchlist button should display Snackbar when added to watchlist",
    (WidgetTester tester) async {
      when(() => mockTvDetailBloc.stream)
          .thenAnswer(((_) => Stream.value(TvDetailStateLoaded(testTVDetail))));
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailStateLoaded(testTVDetail));
      //watchlist event
      when(() => mockWatchlistEventBloc.stream).thenAnswer(((_) =>
          Stream.value(WatchlistEventStateLoaded('Added to Watchlist'))));
      when(() => mockWatchlistEventBloc.state)
          .thenReturn(WatchlistEventStateLoaded('Added to Watchlist'));
      //watchlist status
      when(() => mockWatchlistStatusBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistStatusFalse())));
      when(() => mockWatchlistStatusBloc.state)
          .thenReturn(WatchlistStatusFalse());
      //recommendations
      when(() => mockRecommendationsTvBloc.stream).thenAnswer(
          ((_) => Stream.value(RecommendationsTvStateLoaded(testTVList))));
      when(() => mockRecommendationsTvBloc.state)
          .thenReturn(RecommendationsTvStateLoaded(testTVList));

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    },
  );

  // testWidgets(
  //   "Watchlist button should display AlertDialog when add to watchlist failed",
  //   (WidgetTester tester) async {
  //     when(() => mockTvDetailBloc.stream).thenAnswer(
  //         ((_) => Stream.value(TvDetailStateLoaded(testTVDetail))));
  //     when(() => mockTvDetailBloc.state)
  //         .thenReturn(TvDetailStateLoaded(testTVDetail));
  //     //watchlist event
  //     when(() => mockWatchlistEventBloc.stream).thenAnswer(
  //         ((_) => Stream.value(WatchlistEventStateLoaded('Failed'))));
  //     when(() => mockWatchlistEventBloc.state)
  //         .thenReturn(WatchlistEventStateLoaded('Failed'));
  //     //watchlist status
  //     when(() => mockWatchlistStatusBloc.stream)
  //         .thenAnswer(((_) => Stream.value(WatchlistStatusFalse())));
  //     when(() => mockWatchlistStatusBloc.state)
  //         .thenReturn(WatchlistStatusFalse());
  //     //recommendations
  //     when(() => mockRecommendationsTvBloc.stream).thenAnswer(
  //         ((_) => Stream.value(RecommendationsTvStateLoaded(testTVList))));
  //     when(() => mockRecommendationsTvBloc.state)
  //         .thenReturn(RecommendationsTvStateLoaded(testTVList));

  //     final watchlistButton = find.byType(ElevatedButton);

  //     await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: tId)));

  //     expect(find.byIcon(Icons.add), findsOneWidget);

  //     await tester.tap(watchlistButton);
  //     await tester.pump();

  //     expect(find.byType(AlertDialog), findsOneWidget);
  //     expect(find.text('Failed'), findsOneWidget);
  //   },
  // );

  testWidgets(
    "Display rating of tv ",
    (WidgetTester tester) async {
      when(() => mockTvDetailBloc.stream)
          .thenAnswer(((_) => Stream.value(TvDetailStateLoaded(testTVDetail))));
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailStateLoaded(testTVDetail));
      //watchlist event
      when(() => mockWatchlistEventBloc.stream).thenAnswer(
          ((_) => Stream.value(WatchlistEventStateLoaded('Failed'))));
      when(() => mockWatchlistEventBloc.state)
          .thenReturn(WatchlistEventStateLoaded('Failed'));
      //watchlist status
      when(() => mockWatchlistStatusBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistStatusFalse())));
      when(() => mockWatchlistStatusBloc.state)
          .thenReturn(WatchlistStatusFalse());
      //recommendations
      when(() => mockRecommendationsTvBloc.stream).thenAnswer(
          ((_) => Stream.value(RecommendationsTvStateLoaded(testTVList))));
      when(() => mockRecommendationsTvBloc.state)
          .thenReturn(RecommendationsTvStateLoaded(testTVList));

      final ratingFinder = find.byType(RatingBarIndicator);

      await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

      expect(ratingFinder, findsOneWidget);
    },
  );

  // testWidgets(
  //   "Display genres of tv ",
  //   (WidgetTester tester) async {
  //     when(() => mockTvDetailBloc.stream)
  //         .thenAnswer(((_) => Stream.value(TvDetailStateLoaded(testTVDetail))));
  //     when(() => mockTvDetailBloc.state)
  //         .thenReturn(TvDetailStateLoaded(testTVDetail));
  //     //watchlist event
  //     when(() => mockWatchlistEventBloc.stream).thenAnswer(
  //         ((_) => Stream.value(WatchlistEventStateLoaded('Failed'))));
  //     when(() => mockWatchlistEventBloc.state)
  //         .thenReturn(WatchlistEventStateLoaded('Failed'));
  //     //watchlist status
  //     when(() => mockWatchlistStatusBloc.stream)
  //         .thenAnswer(((_) => Stream.value(WatchlistStatusFalse())));
  //     when(() => mockWatchlistStatusBloc.state)
  //         .thenReturn(WatchlistStatusFalse());
  //     //recommendations
  //     when(() => mockRecommendationsTvBloc.stream).thenAnswer(
  //         ((_) => Stream.value(RecommendationsTvStateLoaded(testTVList))));
  //     when(() => mockRecommendationsTvBloc.state)
  //         .thenReturn(RecommendationsTvStateLoaded(testTVList));

  //     final genreFinder = find.byKey(Key("Genres"));

  //     await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

  //     expect(genreFinder, findsOneWidget);
  //   },
  // );

//   testWidgets(
//     "Display duration of tv ",
//     (WidgetTester tester) async {
//       when(() => mockTvDetailBloc.stream)
//           .thenAnswer(((_) => Stream.value(TvDetailStateLoaded(testTVDetail))));
//       when(() => mockTvDetailBloc.state)
//           .thenReturn(TvDetailStateLoaded(testTVDetail));
//       //watchlist event
//       when(() => mockWatchlistEventBloc.stream).thenAnswer(
//           ((_) => Stream.value(WatchlistEventStateLoaded('Failed'))));
//       when(() => mockWatchlistEventBloc.state)
//           .thenReturn(WatchlistEventStateLoaded('Failed'));
//       //watchlist status
//       when(() => mockWatchlistStatusBloc.stream)
//           .thenAnswer(((_) => Stream.value(WatchlistStatusFalse())));
//       when(() => mockWatchlistStatusBloc.state)
//           .thenReturn(WatchlistStatusFalse());
//       //recommendations
//       when(() => mockRecommendationsTvBloc.stream).thenAnswer(
//           ((_) => Stream.value(RecommendationsTvStateLoaded(testTVList))));
//       when(() => mockRecommendationsTvBloc.state)
//           .thenReturn(RecommendationsTvStateLoaded(testTVList));

//       final durationFinder = find.byKey(Key("Duration"));

//       await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

//       expect(durationFinder, findsOneWidget);
//     },
//   );

//   testWidgets(
//     "Display Season and episode count of tv ",
//     (WidgetTester tester) async {
//       when(() => mockTvDetailBloc.stream)
//           .thenAnswer(((_) => Stream.value(TvDetailStateLoaded(testTVDetail))));
//       when(() => mockTvDetailBloc.state)
//           .thenReturn(TvDetailStateLoaded(testTVDetail));
//       //watchlist event
//       when(() => mockWatchlistEventBloc.stream).thenAnswer(
//           ((_) => Stream.value(WatchlistEventStateLoaded('Failed'))));
//       when(() => mockWatchlistEventBloc.state)
//           .thenReturn(WatchlistEventStateLoaded('Failed'));
//       //watchlist status
//       when(() => mockWatchlistStatusBloc.stream)
//           .thenAnswer(((_) => Stream.value(WatchlistStatusFalse())));
//       when(() => mockWatchlistStatusBloc.state)
//           .thenReturn(WatchlistStatusFalse());
//       //recommendations
//       when(() => mockRecommendationsTvBloc.stream).thenAnswer(
//           ((_) => Stream.value(RecommendationsTvStateLoaded(testTVList))));
//       when(() => mockRecommendationsTvBloc.state)
//           .thenReturn(RecommendationsTvStateLoaded(testTVList));

//       final seasonTitle = find.text("Seasons");
//       final seasonListView = find.byKey(Key("Seasons ListView"));

//       await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

//       expect(seasonTitle, findsOneWidget);
//       expect(seasonListView, findsOneWidget);
//     },
//   );
}
