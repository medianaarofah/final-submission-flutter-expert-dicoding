import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/entities/movie.dart';
part 'movie_recommendations_event.dart';
part 'movie_recommendations_state.dart';

class MovieRecommendationsBloc
    extends Bloc<MovieRecommendationsEvent, MovieRecommendationsState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecommendationsBloc(this._getMovieRecommendations)
      : super(MovieRecommendationsEmpty()) {
    on<OnRecommendationsMovieAppearing>((event, emit) async {
      final id = event.id;

      emit(MovieRecommendationsLoading());

      final result = await _getMovieRecommendations.execute(id);

      result.fold((failure) {
        emit(MovieRecommendationsError(failure.message));
      }, (data) {
        emit(MovieRecommendationsHasData(data));
      });
    });
  }
}
