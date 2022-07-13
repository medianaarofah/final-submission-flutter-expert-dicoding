part of 'search_tv_series_bloc.dart';

abstract class SearchTVSeriesState extends Equatable {
  const SearchTVSeriesState();

  @override
  List<Object> get props => [];
}

class SearchTVSeriesEmpty extends SearchTVSeriesState {}

class SearchTVSeriesLoading extends SearchTVSeriesState {}

class SearchTVSeriesError extends SearchTVSeriesState {
  final String message;

  SearchTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTVSeriesHasData extends SearchTVSeriesState {
  final List<TVSeries> result;

  SearchTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
