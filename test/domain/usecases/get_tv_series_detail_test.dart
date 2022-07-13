import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects_tv_series.dart';
import '../../helpers/test_helper_tv_series.mocks.dart';

void main() {
  late GetTVSeriesDetail usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetTVSeriesDetail(mockTVSeriesRepository);
  });

  final tId = 1;

  test('should get TV Series detail from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.getTVSeriesDetail(tId))
        .thenAnswer((_) async => Right(testTVSeriesDetailEntity));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTVSeriesDetailEntity));
  });
}
