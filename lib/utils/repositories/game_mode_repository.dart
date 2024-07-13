import 'package:dio/dio.dart';
import 'package:kgamify/utils/api.dart';
import 'package:kgamify/utils/models/game_mode_model.dart';

class GameModeRepository{
  final API _api = API();

  Future<List<GameMode>> fetchGameMode({required int champId,int userId = 1}) async {
    try{
      Response response = await _api.sendRequests.get("/get_game_mode.php?champ_id=$champId&user_id=$userId");
      List<dynamic> gameModeData = response.data['data'];
      return gameModeData.map((e) => GameMode.fromJson(e),).toList();
    }
    catch (e){
      rethrow;
    }
  }
}