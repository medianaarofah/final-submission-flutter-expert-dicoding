import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects_tv_series.dart';
import '../../helpers/test_helper_tv_series.mocks.dart';

void main() {
  late SaveTVSeriesWatchlist usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = SaveTVSeriesWatchlist(mockTVSeriesRepository);
  });

  test('should save TV Series to the repository', () async {
    // arrange
    when(mockTVSeriesRepository.saveTVSeriesWatchlist(testTVSeriesDetailEntity))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTVSeriesDetailEntity);
    // assert
    verify(
        mockTVSeriesRepository.saveTVSeriesWatchlist(testTVSeriesDetailEntity));
    expect(result, Right('Added to Watchlist'));
  });
}
