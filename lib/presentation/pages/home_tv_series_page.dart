import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/tv/now_playing_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/search_tv_series_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

class HomeTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv_series';
  @override
  _HomeTVSeriesPageState createState() => _HomeTVSeriesPageState();
}

class _HomeTVSeriesPageState extends State<HomeTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<NowPlayingTVSeriesBloc>()
          .add(OnNowPlayingTVSeriesAppearing());
      context.read<PopularTVSeriesBloc>().add(OnPopularTVSeriesAppearing());
      context.read<TopRatedTVSeriesBloc>().add(OnTopRatedTVSeriesAppearing());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('TV Series'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist TV Series'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTVSeriesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('TV Series Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTVSeriesPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing TV Series',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingTVSeriesBloc, NowPlayingTVSeriesState>(
                  builder: (context, state) {
                if (state is NowPlayingTVSeriesLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingTVSeriesHasData) {
                  final dataTVSeriesResult = state.result;
                  return TVSeriesList(dataTVSeriesResult);
                } else if (state is NowPlayingTVSeriesError) {
                  return Center(child: Text(state.message));
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular TV Series',
                onTap: () => Navigator.pushNamed(
                    context, PopularTVSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTVSeriesBloc, PopularTVSeriesState>(
                  builder: (context, state) {
                if (state is PopularTVSeriesLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTVSeriesHasData) {
                  final dataTVSeriesResult = state.result;
                  return TVSeriesList(dataTVSeriesResult);
                } else if (state is PopularTVSeriesError) {
                  return Center(child: Text(state.message));
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated TV Series',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTVSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
                  builder: (context, state) {
                if (state is TopRatedTVSeriesLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTVSeriesHasData) {
                  final dataTVSeriesResult = state.result;
                  return TVSeriesList(dataTVSeriesResult);
                } else {
                  return Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TVSeriesList extends StatelessWidget {
  final List<TVSeries> tvSeries;

  TVSeriesList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final seriesTv = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVSeriesDetailPage.ROUTE_NAME,
                  arguments: seriesTv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${seriesTv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
