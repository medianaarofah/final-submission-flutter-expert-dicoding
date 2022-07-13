import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv_series_table.dart';

abstract class TVSeriesLocalDataSource {
  Future<String> insertTVSeriesWatchlist(TVSeriesTable tvSeries);
  Future<String> removeTVSeriesWatchlist(TVSeriesTable tvSeries);
  Future<TVSeriesTable?> getTVSeriesById(int id);
  Future<List<TVSeriesTable>> getWatchlistTVSeries();
}

class TVSeriesLocalDataSourceImpl implements TVSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TVSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertTVSeriesWatchlist(TVSeriesTable tvSeries) async {
    try {
      await databaseHelper.insertTVSeriesWatchlist(tvSeries);
      return 'Added to Watchlist TV Series';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTVSeriesWatchlist(TVSeriesTable tvSeries) async {
    try {
      await databaseHelper.removeTVSeriesWatchlist(tvSeries);
      return 'Removed from Watchlist TV Series';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TVSeriesTable?> getTVSeriesById(int id) async {
    final result = await databaseHelper.getTVSeriesById(id);
    if (result != null) {
      return TVSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TVSeriesTable>> getWatchlistTVSeries() async {
    final result = await databaseHelper.getWatchlistTVSeries();
    return result.map((data) => TVSeriesTable.fromMap(data)).toList();
  }
}
