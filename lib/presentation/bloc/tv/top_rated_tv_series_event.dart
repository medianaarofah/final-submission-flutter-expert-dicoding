part of 'top_rated_tv_series_bloc.dart';

abstract class TopRatedTVSeriesEvent extends Equatable {
  const TopRatedTVSeriesEvent();
}

class OnTopRatedTVSeriesAppearing extends TopRatedTVSeriesEvent {
  @override
  List<Object?> get props => [];
}
