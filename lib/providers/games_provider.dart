import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/models/game_info/game_info.dart';
import 'package:one_to_ten_game/models/game_settings/one_to_ten/game_settings.dart';
import 'package:one_to_ten_game/providers/locale_provider.dart';
import 'package:one_to_ten_game/repositories/games/games_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class GamesRepositoryNotifier extends StateNotifier<GamesRepository>{
  GamesRepositoryNotifier() : super(GamesRepository());

  void init(AppLocalizations localizations){
    state = GamesRepository(appLocalizations: localizations);
  }
}

class GameSettingsNotifier extends StateNotifier<GameSettings>{
  //create default value here
  GameSettingsNotifier() : super(GameSettings(info: GameInfo(minRounds: 1, maxRounds: 2,idName: '', minPlayers: 4, maxPlayers: 8, assetPath: '')));

  void init(GameSettings settings){
    state = settings;
  }
  void setRoundsNumber(int roundsCount){
    state = state.copyWith.call(roundsCount: roundsCount);
  }
  void incrementPlayersCount(){
    if(state.playersCount + 1 > state.info.maxPlayers){
      return;
    }
    state = state.copyWith.call(playersCount: state.playersCount + 1);
  }
  void decrementPlayersCount(){
    if(state.playersCount - 1 < state.info.minPlayers){
      return;
    }
    state = state.copyWith.call(playersCount: state.playersCount - 1);
  }
}

final currentGameSettingsProvider = StateNotifierProvider<GameSettingsNotifier, GameSettings>((ref) => GameSettingsNotifier());

final gamesRepositoryProvider = StateNotifierProvider<GamesRepositoryNotifier, GamesRepository>((ref) => GamesRepositoryNotifier());
final gamesProvider = StateProvider<List<GameInfo>>((ref){
  return ref.watch(gamesRepositoryProvider).getGamesList();
});