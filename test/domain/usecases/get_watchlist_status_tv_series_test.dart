import 'package:ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper_tv_series.mocks.dart';

void main() {
  late GetTVSeriesWatchlistStatus usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetTVSeriesWatchlistStatus(mockTVSeriesRepository);
  });

  test('should get watchlist TV Series status from repository', () async {
    // arrange
    when(mockTVSeriesRepository.isInsertTVSeriesToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
