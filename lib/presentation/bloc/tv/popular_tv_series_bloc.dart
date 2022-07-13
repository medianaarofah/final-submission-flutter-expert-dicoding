import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
part 'popular_tv_series_event.dart';
part 'popular_tv_series_state.dart';

class PopularTVSeriesBloc
    extends Bloc<PopularTVSeriesEvent, PopularTVSeriesState> {
  final GetPopularTVSeries _getPopularTVSeries;

  PopularTVSeriesBloc(this._getPopularTVSeries)
      : super(PopularTVSeriesEmpty()) {
    on<OnPopularTVSeriesAppearing>((event, emit) async {
      emit(PopularTVSeriesLoading());

      final result = await _getPopularTVSeries.execute();

      result.fold((failure) {
        emit(PopularTVSeriesError(failure.message));
      }, (data) {
        if (data.isEmpty) {
          emit(PopularTVSeriesEmpty());
        } else {
          emit(PopularTVSeriesHasData(data));
        }
      });
    });
  }
}
