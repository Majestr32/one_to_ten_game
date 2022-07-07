
import 'package:one_to_ten_game/models/game_info/game_info.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'game_settings.freezed.dart';

@freezed
class GameSettings with _$GameSettings{
  const factory GameSettings({
    required GameInfo info,
    @Default(4) int playersCount,
    @Default(3) int roundsCount,
  }) = _GameSettings;



}