import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/routing/app_routes.dart';
import 'package:movies_app/core/domain/models/tmdb_models.dart';
import 'package:movies_app/features/search/presentation/components/search_list_tile.dart';

class SearchList extends StatelessWidget {
  const SearchList({super.key, required this.models});

  final List<TMDBModel> models;

  static Widget shimmerLoading() {
    return ListView.separated(
      separatorBuilder: (context, i) => const SizedBox(height: 20),
      itemBuilder: (context, i) {
        return SearchListTile.shimmerLoading(context);
      },
      itemCount: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, i) => const SizedBox(height: 20),
      itemBuilder: (context, i) {
        final model = models[i];
        switch (model) {
          case MovieModel():
            return InkWell(
              onTap: () => context.go(
                  "${AppRoutes.search}/${AppRoutes.movieDetails}",
                  extra: [model.id, model.title]),
              child: SearchListTile(
                imagePath: model.posterPath,
                title: model.title ?? "Unknown",
                originalTitle: model.originalTitle ?? "Unknown",
                firstAirDate: model.releaseDate,
                voteAverage: model.voteAverage ?? 0,
                genreIds: model.genreIds ?? [],
              ),
            );
          case TVSeriesModel():
            return InkWell(
              onTap: () => context.go(
                  "${AppRoutes.search}/${AppRoutes.tvSeriesDetails}",
                  extra: [model.id, model.name]),
              child: SearchListTile(
                imagePath: model.posterPath,
                title: model.name ?? "Unknown",
                originalTitle: model.originalName ?? "Unknown",
                firstAirDate: model.firstAirDate,
                lastAirDate: model.lastAirDate,
                voteAverage: model.voteAverage ?? 0,
                genreIds: model.genreIds ?? [],
              ),
            );
          case PersonModel():
            return InkWell(
              onTap: () => context.go(
                  "${AppRoutes.search}/${AppRoutes.personDetails}",
                  extra: [model.id, model.name]),
              child: SearchListTile(
                imagePath: model.profilePath,
                title: model.name ?? "Unknonwn",
                originalTitle: model.originalName ?? "Unknown",
                isPerson: true,
              ),
            );
          default:
            return null;
        }
      },
      itemCount: models.length,
    );
  }
}
