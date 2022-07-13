import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/common/failure.dart';

class SaveTVSeriesWatchlist {
  final TVSeriesRepository repository;

  SaveTVSeriesWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TVSeriesDetail movie) {
    return repository.saveTVSeriesWatchlist(movie);
  }
}
