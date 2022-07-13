import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/tv/search_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/search_tv_series';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<SearchTVSeriesBloc>().add(OnQueryChanged(query));
              },
              decoration: InputDecoration(
                hintText: 'Search TV Series name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchTVSeriesBloc, SearchTVSeriesState>(
              builder: (context, state) {
                if (state is SearchTVSeriesLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchTVSeriesHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tvSeries = result[index];
                        return TVSeriesCard(tvSeries);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchTVSeriesError) {
                  return Expanded(child: Center(child: Text(state.message)));
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
