import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
part 'now_playing_tv_series_event.dart';
part 'now_playing_tv_series_state.dart';

class NowPlayingTVSeriesBloc
    extends Bloc<NowPlayingTVSeriesEvent, NowPlayingTVSeriesState> {
  final GetNowPlayingTVSeries _getNowPlayingTVSeries;

  NowPlayingTVSeriesBloc(this._getNowPlayingTVSeries)
      : super(NowPlayingTVSeriesEmpty()) {
    on<OnNowPlayingTVSeriesAppearing>((event, emit) async {
      emit(NowPlayingTVSeriesLoading());

      final result = await _getNowPlayingTVSeries.execute();

      result.fold((failure) {
        emit(NowPlayingTVSeriesError(failure.message));
      }, (data) {
        if (data.isEmpty) {
          emit(NowPlayingTVSeriesEmpty());
        } else {
          emit(NowPlayingTVSeriesHasData(data));
        }
      });
    });
  }
}
