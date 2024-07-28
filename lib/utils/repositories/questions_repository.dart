import 'package:dio/dio.dart';
import 'package:kgamify/utils/api.dart';
import 'package:kgamify/utils/models/questions_model.dart';

class QuestionsRepository {
  final API _api = API();

  Future<List<QuestionsModel>> fetchQuestions(int modeId) async {
    try {
      Response response = await _api.sendRequests.get("/get_question.php?mode_id=$modeId");
      List<dynamic> questionData = response.data['data'];
      return questionData
          .map(
            (e) => QuestionsModel.fromJson(e),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
