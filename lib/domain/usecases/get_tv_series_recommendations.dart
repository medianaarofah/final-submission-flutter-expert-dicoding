import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetTVSeriesRecommendations {
  final TVSeriesRepository repository;

  GetTVSeriesRecommendations(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute(id) {
    return repository.getTVSeriesRecommendations(id);
  }
}
