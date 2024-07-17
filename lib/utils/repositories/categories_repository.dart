import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:kgamify/utils/api.dart';
import 'package:kgamify/utils/models/championship_category_model.dart';

class CategoriesRepository {

  final API _api = API();

  Future<List<ChampionshipCategory>?> fetchCategory() async {
    try{
      Response response = await _api.sendRequests.get("/get_category.php");
      List<dynamic> categories = response.data["data"];
      return categories.map((e) => ChampionshipCategory.fromJson(e),).toList();
    }
    catch(ex){
      log(ex.toString());
    }
    return null;
  }
}