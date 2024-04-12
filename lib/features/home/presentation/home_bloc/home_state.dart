part of 'home_bloc.dart';

class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<MovieModel> popularMovies;
  final List<MovieModel> trendingMovies;
  final List<TVSeriesModel> popularTVSeries;
  final List<TVSeriesModel> trendingTVSeries;
  final List<TVSeriesModel> onTheAirTVSeries;
  final List<PersonModel> popularPersons;

  HomeLoadedState({
    required this.popularMovies,
    required this.trendingMovies,
    required this.popularTVSeries,
    required this.trendingTVSeries,
    required this.onTheAirTVSeries,
    required this.popularPersons,
  });
}

class HomeFailureState extends HomeState {
  final ApiRepositoryFailure failure;

  HomeFailureState({
    required this.failure,
  });
}
