
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/models/game_info/game_info.dart';
import 'package:one_to_ten_game/repositories/games/games_repository_contract.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GamesRepository implements IGamesRepository{
  AppLocalizations? _appLocalizations;

  @override
  List<GameInfo> getGamesList() {
    if(_appLocalizations == null){
      return [];
    }
    return [
      //make constants
      GameInfo(minRounds: 1, maxRounds: 6, idName: "1_to_10", name: _appLocalizations!.one_to_ten_boyz_game, minPlayers: 4, maxPlayers: 8, minMinutesPlay: 15, maxMinutesPlay: 30, assetPath: 'assets/images/21_game.jpg', onClickRoutePath: '/1to10game'),
      GameInfo(minRounds: 3, maxRounds: 15, idName: '', name: _appLocalizations!.drinking_game, minPlayers: 3, maxPlayers: 8, assetPath: 'assets/images/drinks-gd501478bc_1920.jpg'),
      GameInfo(minRounds: 4, maxRounds: 14, idName: '', name: '21', minPlayers: 3, maxPlayers: 6, maxMinutesPlay: 15, assetPath: 'assets/images/people-g253f456c9_1920.jpg')
    ];
  }

  GameInfo getGameByIdName(String idName) => getGamesList().firstWhere((game) => game.idName == idName);



  GamesRepository({
     AppLocalizations? appLocalizations,
  }) : _appLocalizations = appLocalizations;

  @override
  void init(AppLocalizations localizations) {
    _appLocalizations = localizations;
  }
}