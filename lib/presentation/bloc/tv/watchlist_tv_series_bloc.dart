import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTVSeriesBloc
    extends Bloc<WatchlistTVSeriesEvent, WatchlistTVSeriesState> {
  final GetTVSeriesWatchlistStatus _getTVSeriesWatchlistStatus;
  final GetWatchlistTVSeries _getWatchlistTVSeries;
  final RemoveTVSeriesWatchlist _removeTVSeriesWatchlist;
  final SaveTVSeriesWatchlist _saveTVSeriesWatchlist;

  WatchlistTVSeriesBloc(
    this._getTVSeriesWatchlistStatus,
    this._getWatchlistTVSeries,
    this._removeTVSeriesWatchlist,
    this._saveTVSeriesWatchlist,
  ) : super(WatchlistTVSeriesEmpty()) {
    on<OnWatchlistTVSeries>((event, emit) async {
      emit(WatchlistTVSeriesLoading());

      final result = await _getWatchlistTVSeries.execute();

      result.fold((failure) {
        emit(WatchlistTVSeriesError(failure.message));
      }, (data) {
        if (data.isEmpty) {
          emit(WatchlistTVSeriesEmpty());
        } else {
          emit(WatchlistTVSeriesHasData(data));
        }
      });
    });

    on<WatchlistTVSeries>((event, emit) async {
      final id = event.id;

      final result = await _getTVSeriesWatchlistStatus.execute(id);

      emit(AddWatchlist(result));
    });

    on<AddWatchlistTVSeries>((event, emit) async {
      emit(WatchlistTVSeriesLoading());

      final tvSeries = event.tvSeries;

      final result = await _saveTVSeriesWatchlist.execute(tvSeries);

      result.fold((failure) {
        emit(WatchlistTVSeriesError(failure.message));
      }, (message) {
        emit(MessageWatchlist(message));
      });
    });

    on<DeleteWatchlistTVSeries>((event, emit) async {
      final tvSeries = event.tvSeries;

      final result = await _removeTVSeriesWatchlist.execute(tvSeries);

      result.fold((failure) {
        emit(WatchlistTVSeriesError(failure.message));
      }, (message) {
        emit(MessageWatchlist(message));
      });
    });
  }
}
