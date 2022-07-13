import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper_tv_series.mocks.dart';

void main() {
  late GetPopularTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetPopularTVSeries(mockTVSeriesRepository);
  });

  final tvTVSeries = <TVSeries>[];

  group('GetPopularTVSeries Tests', () {
    group('execute', () {
      test(
          'should get list of TV Series from the repository when execute function is called',
          () async {
        // arrange
        when(mockTVSeriesRepository.getPopularTVSeries())
            .thenAnswer((_) async => Right(tvTVSeries));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tvTVSeries));
      });
    });
  });
}
