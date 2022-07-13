import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late WatchlistMovieBloc bloc;
  late MockGetWatchlistMovies mockGetWatchlistMovie;
  late MockGetWatchListStatus mockGetWatchlistMovieStatus;
  late MockSaveWatchlist mockSaveWatchlistMovie;
  late MockRemoveWatchlist mockRemoveWatchlistMovie;

  setUp(() {
    mockGetWatchlistMovie = MockGetWatchlistMovies();
    mockGetWatchlistMovieStatus = MockGetWatchListStatus();
    mockSaveWatchlistMovie = MockSaveWatchlist();
    mockRemoveWatchlistMovie = MockRemoveWatchlist();
    bloc = WatchlistMovieBloc(
      mockGetWatchlistMovieStatus,
      mockGetWatchlistMovie,
      mockRemoveWatchlistMovie,
      mockSaveWatchlistMovie,
    );
  });

  group('Watchlist Movie Bloc Testing', () {
    test('initial state should be empty', () {
      expect(bloc.state, WatchlistMovieEmpty());
    });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovie.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnWatchlistMovie()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovie.execute());
        return OnWatchlistMovie().props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchlistMovie.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnWatchlistMovie()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieError('Server Failure'),
      ],
      verify: (bloc) => WatchlistMovieLoading(),
    );
  });

  group('Movie Watchlist Status Bloc Testing', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovieStatus.execute(tId))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(WatchlistMovie(tId)),
      expect: () => [AddWatchlist(true)],
      verify: (bloc) {
        verify(mockGetWatchlistMovieStatus.execute(tId));
        return WatchlistMovie(tId).props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchlistMovieStatus.execute(tId))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(WatchlistMovie(tId)),
      expect: () => [AddWatchlist(false)],
      verify: (bloc) => WatchlistMovieLoading(),
    );
  });

  group('Add Watchlist Movie Bloc Testing', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSaveWatchlistMovie.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Added to Watchlist Movie'));
        return bloc;
      },
      act: (bloc) => bloc.add(AddWatchlistMovie(testMovieDetail)),
      expect: () => [
        WatchlistMovieLoading(),
        MessageWatchlist('Added to Watchlist Movie'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistMovie.execute(testMovieDetail));
        return AddWatchlistMovie(testMovieDetail).props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSaveWatchlistMovie.execute(testMovieDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('Added to Watchlist Fail')));
        return bloc;
      },
      act: (bloc) => bloc.add(AddWatchlistMovie(testMovieDetail)),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieError('Added to Watchlist Fail'),
      ],
      verify: (bloc) => AddWatchlistMovie(testMovieDetail),
    );
  });

  group('Removed Watchlist Movie Bloc Testing', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockRemoveWatchlistMovie.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Removed from Watchlist Movie'));
        return bloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistMovie(testMovieDetail)),
      expect: () => [
        MessageWatchlist('Removed from Watchlist Movie'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
        return DeleteWatchlistMovie(testMovieDetail).props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Error] when data is unsuccessful to fetch',
      build: () {
        when(mockRemoveWatchlistMovie.execute(testMovieDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('Removed from Watchlist Fail')));
        return bloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistMovie(testMovieDetail)),
      expect: () => [
        WatchlistMovieError('Removed from Watchlist Fail'),
      ],
      verify: (bloc) => DeleteWatchlistMovie(testMovieDetail),
    );
  });
}
