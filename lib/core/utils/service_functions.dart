import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_constants.dart';

bool sameTypes<S, V>() {
  void func<X extends S>() {}
  return func is void Function<X extends V>();
}

double formatVoteAverage({required double voteAverage}) {
  return double.parse(voteAverage.toStringAsFixed(1));
}

Color getVoteColor({
  required BuildContext context,
  required double voteAverage,
  bool isRounded = false,
}) {
  final double vote;

  if (!isRounded) {
    vote = formatVoteAverage(voteAverage: voteAverage);
  } else {
    vote = voteAverage;
  }

  final Color voteColor;
  switch (vote) {
    case (< 4):
      voteColor = Theme.of(context).colorScheme.error;
      break;
    case (< 7):
      voteColor = Theme.of(context).colorScheme.secondary;
      break;
    case (>= 7):
      voteColor = Theme.of(context).colorScheme.tertiary;
      break;
    default:
      voteColor = Theme.of(context).colorScheme.secondary;
  }
  return voteColor;
}

List<String> genreIdsToStrings({required List<dynamic> genreIds}) {
  List<String> resultList = [];
  for (int genreId in genreIds) {
    resultList.add(genresMap[genreId] ?? "");
  }
  return resultList;
}

String genreIdsToString({required List<dynamic> genreIds}) {
  String resultString = "";
  int length = genreIds.length;
  for (int i = 0; i < length; i++) {
    String? genreName = genresMap[genreIds[i]];
    if (genreName != null) {
      resultString += genreName;
      if (i < length - 1 && length > 1) {
        resultString += ', ';
      }
    }
  }
  return resultString;
}
