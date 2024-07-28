import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:kgamify/utils/api.dart';
import 'package:kgamify/utils/models/championship_category_model.dart';

class CategoriesRepository {
  final API _api = API();

  Future<List<ChampionshipCategory>?> fetchCategory() async {
    try {
      Response response = await _api.sendRequests.get("/get_category.php");
      List<dynamic> categories = response.data["data"];
      return categories
          .map(
            (e) => ChampionshipCategory.fromJson(e),
          )
          .toList();
    } catch (ex) {
      log(ex.toString());
    }
    return null;
  }

  Future<List<ChampDetails>?> fetchChampDetails(int champId) async {
    try {
      Response response = await _api.sendRequests.get("/fetch_details?champ_id=$champId");
      List<dynamic> details = response.data['data'];
      return details
          .map(
            (e) => ChampDetails.fromJson(e),
          )
          .toList();
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
