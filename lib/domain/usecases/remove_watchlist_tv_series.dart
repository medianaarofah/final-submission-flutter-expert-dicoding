import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/common/failure.dart';

class RemoveTVSeriesWatchlist {
  final TVSeriesRepository repository;

  RemoveTVSeriesWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TVSeriesDetail tvSeries) {
    return repository.removeTVSeriesWatchlist(tvSeries);
  }
}
