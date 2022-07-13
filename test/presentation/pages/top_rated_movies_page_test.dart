import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late FakeTopRatedMovieBloc fakeTopRatedMovieBloc;

  setUp(() {
    registerFallbackValue(FakeTopRatedMovieEvent());
    registerFallbackValue(FakeTopRatedMovieState());

    fakeTopRatedMovieBloc = FakeTopRatedMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMovieBloc>(
      create: (_) => fakeTopRatedMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeTopRatedMovieBloc.state).thenReturn(TopRatedMovieLoading());

    final viewProgressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);
    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));
    expect(centerFinder, findsOneWidget);
    expect(viewProgressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeTopRatedMovieBloc.state).thenReturn(TopRatedMovieLoading());

    final viewProgressFinder = find.byType(CircularProgressIndicator);
    final listViewFinder = find.byType(Center);
    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));
    expect(listViewFinder, findsOneWidget);
    expect(viewProgressFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeTopRatedMovieBloc.stream).thenAnswer(
        ((_) => Stream.value(TopRatedMovieError('Server Failure'))));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(TopRatedMovieError('Server Failure'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}

class FakeTopRatedMovieEvent extends Fake implements TopRatedMovieEvent {}

class FakeTopRatedMovieState extends Fake implements TopRatedMovieState {}

class FakeTopRatedMovieBloc
    extends MockBloc<TopRatedMovieEvent, TopRatedMovieState>
    implements TopRatedMovieBloc {}
