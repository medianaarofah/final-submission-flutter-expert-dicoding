part of 'popular_tv_series_bloc.dart';

abstract class PopularTVSeriesEvent extends Equatable {
  const PopularTVSeriesEvent();
}

class OnPopularTVSeriesAppearing extends PopularTVSeriesEvent {
  @override
  List<Object?> get props => [];
}
