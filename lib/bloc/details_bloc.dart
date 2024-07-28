import 'package:kgamify/utils/models/championship_category_model.dart';

import '../utils/exports.dart';
import '../utils/repositories/categories_repository.dart';

abstract class FetchDetailsState {}

class Fetching extends FetchDetailsState{}

class Fetched extends FetchDetailsState{
  List<ChampDetails> models;
  Fetched(this.models);
}

class ErrorFetching extends FetchDetailsState{
  final String error;
  ErrorFetching(this.error);
}


class GameDetailsBloc extends Cubit<FetchDetailsState>{
  GameDetailsBloc() : super(Fetching());


  final CategoriesRepository _categoriesRepository = CategoriesRepository();
  List<ChampDetails>? models;


  void fetchDetails(int champId) async {
    try{
      models = await _categoriesRepository.fetchChampDetails(champId);
      emit(Fetched(models!));
    } catch (e) {
      emit(ErrorFetching(e.toString()));
    }
  }

}