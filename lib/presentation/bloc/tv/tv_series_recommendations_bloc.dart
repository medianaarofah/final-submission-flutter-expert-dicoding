import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
part 'tv_series_recommendations_event.dart';
part 'tv_series_recommendations_state.dart';

class TVSeriesRecommendationsBloc
    extends Bloc<TVSeriesRecommendationsEvent, TVSeriesRecommendationsState> {
  final GetTVSeriesRecommendations _getTVSeriesRecommendations;

  TVSeriesRecommendationsBloc(this._getTVSeriesRecommendations)
      : super(TVSeriesRecommendationsEmpty()) {
    on<OnTVSeriesRecommendationsAppearing>((event, emit) async {
      final id = event.id;

      emit(TVSeriesRecommendationsLoading());

      final result = await _getTVSeriesRecommendations.execute(id);

      result.fold((failure) {
        emit(TVSeriesRecommendationsError(failure.message));
      }, (data) {
        emit(TVSeriesRecommendationsHasData(data));
      });
    });
  }
}
