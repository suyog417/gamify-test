import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgamify/utils/models/game_mode_model.dart';
import 'package:kgamify/utils/repositories/game_mode_repository.dart';

abstract class GameModeStates{}

class GameModeLoadedState extends GameModeStates{
  final List<GameMode>? models;
  GameModeLoadedState(this.models);
}
class GameModeLoadingState extends GameModeStates{}
class GameModeErrorState extends GameModeStates{
  final String error;
  GameModeErrorState(this.error);
}

class GameModeBloc extends Cubit<GameModeStates>{
  GameModeBloc() : super(GameModeLoadingState());

  GameModeRepository gameModeRepository = GameModeRepository();
  void getGameModes({required int champId}) async {
    try{
      List<GameMode> gameModeModels = await gameModeRepository.fetchGameMode(champId: champId);
      emit(GameModeLoadedState(gameModeModels));
    }catch(e){
      emit(GameModeErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}