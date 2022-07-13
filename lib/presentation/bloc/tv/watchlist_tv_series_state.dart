part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTVSeriesState extends Equatable {
  const WatchlistTVSeriesState();

  @override
  List<Object> get props => [];
}

class WatchlistTVSeriesEmpty extends WatchlistTVSeriesState {
  @override
  List<Object> get props => [];
}

class WatchlistTVSeriesLoading extends WatchlistTVSeriesState {
  @override
  List<Object> get props => [];
}

class WatchlistTVSeriesError extends WatchlistTVSeriesState {
  String message;
  WatchlistTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTVSeriesHasData extends WatchlistTVSeriesState {
  final List<TVSeries> result;

  WatchlistTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class AddWatchlist extends WatchlistTVSeriesState {
  final bool status;

  AddWatchlist(this.status);
}

class MessageWatchlist extends WatchlistTVSeriesState {
  final String message;

  MessageWatchlist(this.message);

  @override
  List<Object> get props => [message];
}
