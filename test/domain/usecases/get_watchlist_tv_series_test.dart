import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects_tv_series.dart';
import '../../helpers/test_helper_tv_series.mocks.dart';

void main() {
  late GetWatchlistTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetWatchlistTVSeries(mockTVSeriesRepository);
  });

  test('should get list of TV Series from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.getWatchlistTVSeries())
        .thenAnswer((_) async => Right(testTVSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTVSeriesList));
  });
}
