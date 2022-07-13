part of 'now_playing_tv_series_bloc.dart';

abstract class NowPlayingTVSeriesState extends Equatable {
  const NowPlayingTVSeriesState();

  @override
  List<Object> get props => [];
}

class NowPlayingTVSeriesEmpty extends NowPlayingTVSeriesState {
  @override
  List<Object> get props => [];
}

class NowPlayingTVSeriesLoading extends NowPlayingTVSeriesState {
  @override
  List<Object> get props => [];
}

class NowPlayingTVSeriesError extends NowPlayingTVSeriesState {
  final String message;

  NowPlayingTVSeriesError(this.message);
}

class NowPlayingTVSeriesHasData extends NowPlayingTVSeriesState {
  final List<TVSeries> result;

  NowPlayingTVSeriesHasData(this.result);

  @override
  List<Object> get props => [];
}
