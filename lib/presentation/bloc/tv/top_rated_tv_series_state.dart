part of 'top_rated_tv_series_bloc.dart';

abstract class TopRatedTVSeriesState extends Equatable {
  const TopRatedTVSeriesState();

  @override
  List<Object> get props => [];
}

class TopRatedTVSeriesEmpty extends TopRatedTVSeriesState {
  @override
  List<Object> get props => [];
}

class TopRatedTVSeriesLoading extends TopRatedTVSeriesState {
  @override
  List<Object> get props => [];
}

class TopRatedTVSeriesError extends TopRatedTVSeriesState {
  final String message;

  TopRatedTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTVSeriesHasData extends TopRatedTVSeriesState {
  final List<TVSeries> result;

  TopRatedTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
