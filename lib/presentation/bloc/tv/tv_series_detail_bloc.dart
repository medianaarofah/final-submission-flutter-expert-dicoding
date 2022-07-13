import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TVSeriesDetailBloc
    extends Bloc<TVSeriesDetailEvent, TVSeriesDetailState> {
  final GetTVSeriesDetail _getTVSeriesDetail;

  TVSeriesDetailBloc(this._getTVSeriesDetail) : super(TVSeriesDetailEmpty()) {
    on<OnTVSeriesDetailAppearing>((event, emit) async {
      final id = event.id;

      emit(TVSeriesDetailLoading());

      final result = await _getTVSeriesDetail.execute(id);

      result.fold((failure) {
        emit(TVSeriesDetailError(failure.message));
      }, (data) {
        emit(TVSeriesDetailHasData(data));
      });
    });
  }
}
