import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetNowPlayingTVSeries {
  final TVSeriesRepository repository;

  GetNowPlayingTVSeries(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getNowPlayingTVSeries();
  }
}
