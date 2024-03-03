import 'package:movies_app/core/data/clients/tmdb_account_api_client.dart';
import 'package:movies_app/core/domain/models/tmdb_models.dart';

class TMDBAccountRepository {
  static final TMDBAccountApiClient _accountApiClient = TMDBAccountApiClient();

  Future<int> onGetAccountId({required String sessionId}) async {
    final response = await _accountApiClient.getAccountId(sessionId: sessionId);
    if (response == null) {
      throw Exception("No response from getAccountId");
    }
    return response.data["id"] as int;
  }

  Future<void> onMarkAsFavorite({
    required int accountId,
    required String sessionId,
    required TMDBMediaType mediaType,
    required int mediaId,
    required bool isFavorite,
  }) async {
    final response = await _accountApiClient.markAsFavourite(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: mediaType,
      mediaId: mediaId,
      isFavorite: isFavorite,
    );
    if (response == null) {
      throw Exception("No response from markAsFavourite");
    }
  }
}
