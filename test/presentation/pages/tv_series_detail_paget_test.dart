import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_recommendations_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist_tv_series_bloc.dart';

import '../../dummy_data/dummy_objects_tv_series.dart';

void main() {
  late FakeTVSeriesDetailBloc fakeTVSeriesDetailBloc;
  late FakeWatchlistTVSeriesBloc fakeWatchlistTVSeriesBloc;
  late FakeTVSeriesRecommendationsBloc fakeTVSeriesRecommendationsBloc;

  setUpAll(() {
    registerFallbackValue(FakeTVSeriesDetailEvent());
    registerFallbackValue(FakeTVSeriesDetailState());

    registerFallbackValue(FakeWatchlistTVSeriesEvent());
    registerFallbackValue(FakeWatchlistTVSeriesState());

    registerFallbackValue(FakeTVSeriesRecommendationsEvent());
    registerFallbackValue(FakeTVSeriesRecommendationsState());
  });

  setUp(() {
    fakeTVSeriesDetailBloc = FakeTVSeriesDetailBloc();
    fakeWatchlistTVSeriesBloc = FakeWatchlistTVSeriesBloc();
    fakeTVSeriesRecommendationsBloc = FakeTVSeriesRecommendationsBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TVSeriesDetailBloc>(
          create: (_) => fakeTVSeriesDetailBloc,
        ),
        BlocProvider<WatchlistTVSeriesBloc>(
          create: (_) => fakeWatchlistTVSeriesBloc,
        ),
        BlocProvider<TVSeriesRecommendationsBloc>(
          create: (_) => fakeTVSeriesRecommendationsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeTVSeriesDetailBloc.close();
    fakeWatchlistTVSeriesBloc.close();
    fakeTVSeriesRecommendationsBloc.close();
  });

  testWidgets('Page should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeTVSeriesDetailBloc.state)
        .thenReturn(TVSeriesDetailLoading());
    when(() => fakeWatchlistTVSeriesBloc.state)
        .thenReturn(WatchlistTVSeriesLoading());
    when(() => fakeTVSeriesRecommendationsBloc.state)
        .thenReturn(TVSeriesRecommendationsLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TVSeriesDetailPage(
      id: 1,
    )));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets('Should widget display which all required',
      (WidgetTester tester) async {
    when(() => fakeTVSeriesDetailBloc.state)
        .thenReturn(TVSeriesDetailHasData(testTVSeriesDetailResponseEntity));
    when(() => fakeWatchlistTVSeriesBloc.state)
        .thenReturn(WatchlistTVSeriesHasData(testTVSeriesList));
    when(() => fakeTVSeriesRecommendationsBloc.state)
        .thenReturn(TVSeriesRecommendationsHasData(testTVSeriesList));
    await tester.pumpWidget(_makeTestableWidget(TVSeriesDetailPage(id: 1)));
    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
    expect(find.text('Season'), findsOneWidget);
  });

  testWidgets(
      'Should display add icon when Tvseries is not added to watchlist in watchlist button',
      (WidgetTester tester) async {
    when(() => fakeTVSeriesDetailBloc.state)
        .thenReturn(TVSeriesDetailHasData(testTVSeriesDetailResponseEntity));
    when(() => fakeWatchlistTVSeriesBloc.state).thenReturn(AddWatchlist(false));
    when(() => fakeTVSeriesRecommendationsBloc.state)
        .thenReturn(TVSeriesRecommendationsHasData(testTVSeriesList));
    final addIconFinder = find.byIcon(Icons.add);
    await tester.pumpWidget(_makeTestableWidget(TVSeriesDetailPage(id: 1)));
    await tester.pump();
    expect(addIconFinder, findsOneWidget);
  });

  testWidgets(
      'Should display check icon when Tvseries is added to watchlist in watchlist button',
      (WidgetTester tester) async {
    when(() => fakeTVSeriesDetailBloc.state)
        .thenReturn(TVSeriesDetailHasData(testTVSeriesDetailResponseEntity));
    when(() => fakeWatchlistTVSeriesBloc.state).thenReturn(AddWatchlist(true));
    when(() => fakeTVSeriesRecommendationsBloc.state)
        .thenReturn(TVSeriesRecommendationsHasData(testTVSeriesList));
    final checkIconFinder = find.byIcon(Icons.check);
    await tester.pumpWidget(_makeTestableWidget(TVSeriesDetailPage(id: 1)));
    await tester.pump();
    expect(checkIconFinder, findsOneWidget);
  });
}

class FakeTVSeriesDetailEvent extends Fake implements TVSeriesDetailEvent {}

class FakeTVSeriesDetailState extends Fake implements TVSeriesDetailState {}

class FakeTVSeriesDetailBloc
    extends MockBloc<TVSeriesDetailEvent, TVSeriesDetailState>
    implements TVSeriesDetailBloc {}

class FakeTVSeriesRecommendationsEvent extends Fake
    implements TVSeriesRecommendationsEvent {}

class FakeTVSeriesRecommendationsState extends Fake
    implements TVSeriesRecommendationsState {}

class FakeTVSeriesRecommendationsBloc
    extends MockBloc<TVSeriesRecommendationsEvent, TVSeriesRecommendationsState>
    implements TVSeriesRecommendationsBloc {}

class FakeWatchlistTVSeriesEvent extends Fake
    implements WatchlistTVSeriesEvent {}

class FakeWatchlistTVSeriesState extends Fake
    implements WatchlistTVSeriesState {}

class FakeWatchlistTVSeriesBloc
    extends MockBloc<WatchlistTVSeriesEvent, WatchlistTVSeriesState>
    implements WatchlistTVSeriesBloc {}
