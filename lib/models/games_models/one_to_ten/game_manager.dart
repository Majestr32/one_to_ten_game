
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:one_to_ten_game/models/games_models/one_to_ten/player.dart';

import 'answer.dart';

part 'game_manager.freezed.dart';

enum GameStatus{
  answering,
  lastQuestion,
  guessing,
  end
}
@freezed
class GameManager with _$GameManager{
  const GameManager._();
  const factory GameManager({
    @Default([]) List<Player> players,
    @Default([]) List<String> randomQuestions,
    @Default([]) List<String> allQuestions,
    @Default("") String question,
    @Default(GameStatus.answering) GameStatus status,
    @Default(0) int currentRound,
    @Default(0) int currentSubRound,
    @Default(2) int currentPlayerNumber,
    @Default(1) int guesserPlayerNumber,
    @Default([]) List<Answer> realAnswers,
    @Default([]) List<Answer> guessedAnswers,
  }) = _GameManager;

  String get currentPlayerName => players[currentPlayerNumber - 1].name;
  String get guesserPlayerName => players[guesserPlayerNumber - 1].name;
}