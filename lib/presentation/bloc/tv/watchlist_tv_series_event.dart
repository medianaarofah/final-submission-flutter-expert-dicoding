part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTVSeriesEvent extends Equatable {
  const WatchlistTVSeriesEvent();
}

class OnWatchlistTVSeries extends WatchlistTVSeriesEvent {
  @override
  List<Object> get props => [];
}

class WatchlistTVSeries extends WatchlistTVSeriesEvent {
  final int id;

  WatchlistTVSeries(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlistTVSeries extends WatchlistTVSeriesEvent {
  final TVSeriesDetail tvSeries;

  AddWatchlistTVSeries(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class DeleteWatchlistTVSeries extends WatchlistTVSeriesEvent {
  final TVSeriesDetail tvSeries;

  DeleteWatchlistTVSeries(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}
