import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:equatable/equatable.dart';

class TVSeriesResponse extends Equatable {
  final List<TVSeriesModel> listTVSeries;

  TVSeriesResponse({required this.listTVSeries});

  factory TVSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TVSeriesResponse(
        listTVSeries: List<TVSeriesModel>.from((json["results"] as List)
            .map((x) => TVSeriesModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(listTVSeries.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [listTVSeries];
}
