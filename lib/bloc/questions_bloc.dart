import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgamify/utils/models/questions_model.dart';
import 'package:kgamify/utils/repositories/questions_repository.dart';

abstract class QuestionsState{}

class QuestionLoadingState extends QuestionsState{}

class QuestionLoadedState extends QuestionsState{
  final List<Questions> questionModels;
  QuestionLoadedState(this.questionModels);
}

class QuestionErrorState extends QuestionsState{
  final String error;
  QuestionErrorState(this.error);
}

class QuestionAnsweredState extends QuestionsState{}

class QuestionsBloc extends Cubit<QuestionsState>{
  QuestionsBloc() : super(QuestionLoadingState());

  QuestionsRepository questionsRepository = QuestionsRepository();

  void getQuestions(int modeId) async {
    try{
      List<Questions> questionData = await questionsRepository.fetchQuestions(modeId);
      emit(QuestionLoadedState(questionData));
    }
    catch(e){
      emit(QuestionErrorState(e.toString()));
    }
  }

  void questionAnswered() {
    emit(QuestionAnsweredState());
  }

}