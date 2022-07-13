import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper_tv_series.mocks.dart';

void main() {
  late GetTopRatedTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetTopRatedTVSeries(mockTVSeriesRepository);
  });

  final tvTVSeries = <TVSeries>[];

  test('should get list of TV Series from repository', () async {
    // arrange
    when(mockTVSeriesRepository.getTopRatedTVSeries())
        .thenAnswer((_) async => Right(tvTVSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tvTVSeries));
  });
}
