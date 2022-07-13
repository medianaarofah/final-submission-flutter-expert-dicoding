import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects_tv_series.dart';
import '../../helpers/test_helper_tv_series.mocks.dart';

void main() {
  late TVSeriesRepositoryImpl repository;
  late MockTVSeriesRemoteDataSource mockRemoteDataSource;
  late MockTVSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTVSeriesRemoteDataSource();
    mockLocalDataSource = MockTVSeriesLocalDataSource();
    repository = TVSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('Now Playing TV Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTVSeries())
          .thenAnswer((_) async => testTVSeriesModelList);
      // act
      final result = await repository.getNowPlayingTVSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTVSeries());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTVSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTVSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingTVSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTVSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTVSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingTVSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTVSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TV Series', () {
    test('should return TV Series list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVSeries())
          .thenAnswer((_) async => testTVSeriesModelList);
      // act
      final result = await repository.getPopularTVSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTVSeriesList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTVSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTVSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TV Series', () {
    test('should return TV Series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVSeries())
          .thenAnswer((_) async => testTVSeriesModelList);
      // act
      final result = await repository.getTopRatedTVSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTVSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTVSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTVSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get TV Series Recommendations', () {
    final tTVSeriesList = <TVSeriesModel>[];
    final tId = 1;

    test('should return data (TV Series list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesRecommendations(tId))
          .thenAnswer((_) async => tTVSeriesList);
      // act
      final result = await repository.getTVSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVSeriesRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTVSeriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTVSeriesRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTVSeriesRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVSeriesRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search TV Series', () {
    final tQuery = 'Halo';

    test('should return TV Series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVSeries(tQuery))
          .thenAnswer((_) async => testTVSeriesModelList);
      // act
      final result = await repository.searchTVSeries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTVSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVSeries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTVSeries(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVSeries(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTVSeries(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertTVSeriesWatchlist(testTVSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository
          .saveTVSeriesWatchlist(testTVSeriesDetailResponseEntity);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertTVSeriesWatchlist(testTVSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository
          .saveTVSeriesWatchlist(testTVSeriesDetailResponseEntity);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });
  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeTVSeriesWatchlist(testTVSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository
          .removeTVSeriesWatchlist(testTVSeriesDetailResponseEntity);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeTVSeriesWatchlist(testTVSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository
          .removeTVSeriesWatchlist(testTVSeriesDetailResponseEntity);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTVSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isInsertTVSeriesToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist TV Series', () {
    test('should return list of TV Series', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTVSeries())
          .thenAnswer((_) async => testTVSeriesTableList);
      // act
      final result = await repository.getWatchlistTVSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, testWatchlistTVSeries);
    });
  });
}
