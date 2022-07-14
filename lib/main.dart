import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/ssl_pinning.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/search_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/now_playing_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/search_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/home_tv_series_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/search_tv_series_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_series_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieRecommendationsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSeriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSeriesRecommendationsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingTVSeriesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());

            case HomeTVSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTVSeriesPage());
            case PopularTVSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTVSeriesPage());
            case TopRatedTVSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTVSeriesPage());
            case SearchTVSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTVSeriesPage());
            case TVSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => TVSeriesDetailPage(id: id),
                  settings: settings);
            case WatchlistTVSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTVSeriesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
