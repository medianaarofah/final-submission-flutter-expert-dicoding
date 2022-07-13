import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects_tv_series.dart';
import '../../helpers/test_helper_tv_series.mocks.dart';

void main() {
  late RemoveTVSeriesWatchlist usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = RemoveTVSeriesWatchlist(mockTVSeriesRepository);
  });

  test('should remove watchlist TV Series from repository', () async {
    // arrange
    when(mockTVSeriesRepository
            .removeTVSeriesWatchlist(testTVSeriesDetailEntity))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTVSeriesDetailEntity);
    // assert
    verify(mockTVSeriesRepository
        .removeTVSeriesWatchlist(testTVSeriesDetailEntity));
    expect(result, Right('Removed from watchlist'));
  });
}
