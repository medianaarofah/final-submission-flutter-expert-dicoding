import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetWatchlistTVSeries {
  final TVSeriesRepository _repository;

  GetWatchlistTVSeries(this._repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    return _repository.getWatchlistTVSeries();
  }
}
