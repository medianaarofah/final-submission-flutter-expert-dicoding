import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late FakeWatchlistTVSeriesBloc fakeWatchlistTVSeriesBloc;

  setUp(() {
    registerFallbackValue(FakeWatchlistTVSeriesEvent());
    registerFallbackValue(FakeWatchlistTVSeriesState());

    fakeWatchlistTVSeriesBloc = FakeWatchlistTVSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTVSeriesBloc>(
      create: (_) => fakeWatchlistTVSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeWatchlistTVSeriesBloc.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeWatchlistTVSeriesBloc.state)
        .thenReturn(WatchlistTVSeriesLoading());

    final viewProgressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);
    await tester.pumpWidget(_makeTestableWidget(WatchlistTVSeriesPage()));
    expect(centerFinder, findsOneWidget);
    expect(viewProgressFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeWatchlistTVSeriesBloc.state)
        .thenReturn(WatchlistTVSeriesLoading());

    final viewProgressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);
    await tester.pumpWidget(_makeTestableWidget(WatchlistTVSeriesPage()));
    expect(viewProgressFinder, findsOneWidget);
    expect(centerFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeWatchlistTVSeriesBloc.stream).thenAnswer(
        ((_) => Stream.value(WatchlistTVSeriesError('Server Failure'))));
    when(() => fakeWatchlistTVSeriesBloc.state)
        .thenReturn(WatchlistTVSeriesError('Server Failure'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTVSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}

class FakeWatchlistTVSeriesEvent extends Fake
    implements WatchlistTVSeriesEvent {}

class FakeWatchlistTVSeriesState extends Fake
    implements WatchlistTVSeriesState {}

class FakeWatchlistTVSeriesBloc
    extends MockBloc<WatchlistTVSeriesEvent, WatchlistTVSeriesState>
    implements WatchlistTVSeriesBloc {}
