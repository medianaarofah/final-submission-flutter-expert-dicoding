import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv_series.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTVSeries,
  GetTVSeriesWatchlistStatus,
  SaveTVSeriesWatchlist,
  RemoveTVSeriesWatchlist,
])
void main() {
  late WatchlistTVSeriesBloc bloc;
  late MockGetWatchlistTVSeries mockGetWatchlistTVSeries;
  late MockGetTVSeriesWatchlistStatus mockGetTVSeriesWatchlistStatus;
  late MockRemoveTVSeriesWatchlist mockRemoveTVSeriesWatchlist;
  late MockSaveTVSeriesWatchlist mockSaveTVSeriesWatchlist;

  setUp(() {
    mockGetWatchlistTVSeries = MockGetWatchlistTVSeries();
    mockGetTVSeriesWatchlistStatus = MockGetTVSeriesWatchlistStatus();
    mockRemoveTVSeriesWatchlist = MockRemoveTVSeriesWatchlist();
    mockSaveTVSeriesWatchlist = MockSaveTVSeriesWatchlist();
    bloc = WatchlistTVSeriesBloc(
      mockGetTVSeriesWatchlistStatus,
      mockGetWatchlistTVSeries,
      mockRemoveTVSeriesWatchlist,
      mockSaveTVSeriesWatchlist,
    );
  });
  group('TV Series Watchlist Bloc Testing', () {
    test('initial state should be empty', () {
      expect(bloc.state, WatchlistTVSeriesEmpty());
    });

    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTVSeries.execute())
            .thenAnswer((_) async => Right(testTVSeriesList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTVSeries()),
      expect: () => [
        WatchlistTVSeriesLoading(),
        WatchlistTVSeriesHasData(testTVSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTVSeries.execute());
        return OnWatchlistTVSeries().props;
      },
    );

    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, Error] when data is unsuccessful to fetch',
      build: () {
        when(mockGetWatchlistTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTVSeries()),
      expect: () => [
        WatchlistTVSeriesLoading(),
        WatchlistTVSeriesError('Server Failure'),
      ],
      verify: (bloc) => WatchlistTVSeriesLoading(),
    );
  });

  group('TV Series Watchlist Status Bloc Testing', () {
    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTVSeriesWatchlistStatus.execute(tId))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(WatchlistTVSeries(tId)),
      expect: () => [AddWatchlist(true)],
      verify: (bloc) {
        verify(mockGetTVSeriesWatchlistStatus.execute(tId));
        return WatchlistTVSeries(tId).props;
      },
    );

    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, Error] when data is unsuccessful to fetch',
      build: () {
        when(mockGetTVSeriesWatchlistStatus.execute(tId))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(WatchlistTVSeries(tId)),
      expect: () => [AddWatchlist(false)],
      verify: (bloc) => WatchlistTVSeriesLoading(),
    );
  });

  group('Add Watchlist TV Series Bloc Testing', () {
    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSaveTVSeriesWatchlist
                .execute(testTVSeriesDetailResponseEntity))
            .thenAnswer((_) async => Right('Added to Watchlist TV Series'));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(AddWatchlistTVSeries(testTVSeriesDetailResponseEntity)),
      expect: () => [
        WatchlistTVSeriesLoading(),
        MessageWatchlist('Added to Watchlist TV Series'),
      ],
      verify: (bloc) {
        verify(mockSaveTVSeriesWatchlist
            .execute(testTVSeriesDetailResponseEntity));
        return AddWatchlistTVSeries(testTVSeriesDetailResponseEntity).props;
      },
    );

    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, Error] when data is unsuccessful to fetch',
      build: () {
        when(mockSaveTVSeriesWatchlist
                .execute(testTVSeriesDetailResponseEntity))
            .thenAnswer(
                (_) async => Left(DatabaseFailure('Added to Watchlist Fail')));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(AddWatchlistTVSeries(testTVSeriesDetailResponseEntity)),
      expect: () => [
        WatchlistTVSeriesLoading(),
        WatchlistTVSeriesError('Added to Watchlist Fail'),
      ],
      verify: (bloc) => AddWatchlistTVSeries(testTVSeriesDetailResponseEntity),
    );
  });

  group('Removed watchlist tv series bloc testing', () {
    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockRemoveTVSeriesWatchlist
                .execute(testTVSeriesDetailResponseEntity))
            .thenAnswer((_) async => Right('Removed from Watchlist TV Series'));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(DeleteWatchlistTVSeries(testTVSeriesDetailResponseEntity)),
      expect: () => [
        MessageWatchlist('Removed from Watchlist TV Series'),
      ],
      verify: (bloc) {
        verify(mockRemoveTVSeriesWatchlist
            .execute(testTVSeriesDetailResponseEntity));
        return DeleteWatchlistTVSeries(testTVSeriesDetailResponseEntity).props;
      },
    );

    blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
      'Should emit [Loading, Error] when data is unsuccessful to fetch',
      build: () {
        when(mockRemoveTVSeriesWatchlist
                .execute(testTVSeriesDetailResponseEntity))
            .thenAnswer((_) async =>
                Left(DatabaseFailure('Removed from Watchlist Fail')));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(DeleteWatchlistTVSeries(testTVSeriesDetailResponseEntity)),
      expect: () => [
        WatchlistTVSeriesError('Removed from Watchlist Fail'),
      ],
      verify: (bloc) =>
          DeleteWatchlistTVSeries(testTVSeriesDetailResponseEntity),
    );
  });
}
