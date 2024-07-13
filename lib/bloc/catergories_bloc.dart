import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgamify/utils/models/championship_category_model.dart';
import 'package:kgamify/utils/repositories/categories_repository.dart';

abstract class CategoriesStates{}

class CategoriesLoadingState extends CategoriesStates{}

class CategoriesLoadedState extends CategoriesStates{
  final List<ChampionshipCategory>? models;
  CategoriesLoadedState(this.models);
}

class CategoriesErrorState extends CategoriesStates{
  final String error;
  CategoriesErrorState(this.error);
}

class CategoriesBloc extends Cubit<CategoriesStates>{
  CategoriesBloc() : super(CategoriesLoadingState()) {
    getCategories();
  }

  final CategoriesRepository _categoriesRepository = CategoriesRepository();
  List<ChampionshipCategory>? models;

  void getCategories() async {
    try{
      models =  await _categoriesRepository.fetchCategory();
      emit(CategoriesLoadedState(models));
    }
    catch(e){
      emit(CategoriesErrorState(e.toString()));
    }
  }

  void searchChampionship(String query){
    emit(CategoriesLoadedState(models!.where((element) => element.champName!.toLowerCase().contains(query),).toList()));
  }
  void sortChampionships(String sortBy){

  }
}