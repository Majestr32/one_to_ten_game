
import 'dart:math';
import 'dart:developer' as dev;

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/models/games_models/one_to_ten/game_manager.dart';

import '../models/game_settings/one_to_ten/game_settings.dart';
import '../models/games_models/one_to_ten/answer.dart';
import '../models/games_models/one_to_ten/player.dart';

final oneToTenGameProvider = StateNotifierProvider<OneToTenGameNotifier, GameManager>((ref) => OneToTenGameNotifier());

class OneToTenGameNotifier extends StateNotifier<GameManager>{
  GameSettings? _gameSettings;
  OneToTenGameNotifier({GameSettings? gameSettings}) : super(GameManager()){
    _gameSettings = gameSettings;
  }

  void init(GameSettings gameSettings){
    _gameSettings = gameSettings;
    state = state.copyWith.call(question: _randomQuestion(),players: List.generate(_gameSettings!.playersCount, (index) => Player(number: index + 1, score: 0)));
  }
  void submitAnswer(Answer answer){
    state = state.copyWith.call(realAnswers: [...state.realAnswers, answer]);
  }
  void editAnswer(Answer answer){
    final newAnswers = state.realAnswers.map((e){
      if(e.playerNumber == answer.playerNumber){
        return answer;
      }
      return e;
    }).toList();
    state = state.copyWith(realAnswers: newAnswers);
  }
  void submitGuesses(List<Answer> guessedAnswers){
    state = state.copyWith.call(guessedAnswers: guessedAnswers);
    next();
  }
  void next(){
    final maxSubrounds = _gameSettings!.playersCount;
    final guesserPlayerNumber = state.guesserPlayerNumber;
    final currentPlayerNumber = state.currentPlayerNumber;
    if(state.status == GameStatus.guessing){
      return;
    }
    if(state.status == GameStatus.lastQuestion){
      _notifyNextIsGuessing();
      return;
    }
    if((currentPlayerNumber >= maxSubrounds - 2 && guesserPlayerNumber == maxSubrounds) || (currentPlayerNumber >= maxSubrounds - 2 && guesserPlayerNumber == maxSubrounds - 1) || (currentPlayerNumber >= maxSubrounds - 1 && guesserPlayerNumber != maxSubrounds))
    {
      _notifyNextPlayerIsLast();
    }
    _nextPlayer();
  }

  void _notifyNextPlayerIsLast(){
    state = state.copyWith.call(status: GameStatus.lastQuestion);
  }
  void calculateScores(){
    int scores = 0;
    for(var realAnswer in state.realAnswers){
      for(var guessedAnswer in state.guessedAnswers){
        if(realAnswer.playerNumber == guessedAnswer.playerNumber && realAnswer.answer == guessedAnswer.answer){
          scores += 2;
        }
      }
    }
    final nonGuessers = state.players.where((pl) => pl.number != state.guesserPlayerNumber);
    final guesser = state.players.firstWhere((pl) => pl.number == state.guesserPlayerNumber);
    final updatedGuesser = Player(number: state.guesserPlayerNumber, score: guesser.score + scores);
    state = state.copyWith.call(players: [...nonGuessers, updatedGuesser]);
  }
  void generateThreeRandomQuestions(){
    List<String> randomQuestions = [];
    randomQuestions.add(_randomQuestion());
    randomQuestions.add(_randomQuestion());
    randomQuestions.add(_randomQuestion());
    state = state.copyWith(randomQuestions: randomQuestions);
  }
  void chooseQuestion(String question){
    state = state.copyWith(question: question);
  }
  String _randomQuestion(){
    final questions = [
      "Who are you?",
      "What are you doing?",
      "Tell",
      "Do you know?",
      "Tell me your friend"
    ];
    final _random = new Random();
    return questions[_random.nextInt(questions.length)];
  }
  void _notifyNextIsGuessing(){
    state = state.copyWith.call(status: GameStatus.guessing);
  }
  void nextSubround(){
    final guesserPlayerNumber = state.guesserPlayerNumber;
    final currentPlayerNumber = state.currentPlayerNumber;
    final maxSubrounds = _gameSettings!.playersCount;

    dev.log("state before round ends: current round " + state.currentRound.toString() + " guesserplayernumber " + guesserPlayerNumber.toString() + " rounds count " + _gameSettings!.roundsCount.toString() + " current play " + currentPlayerNumber.toString());
    if(state.currentRound + 1 >= _gameSettings!.roundsCount && guesserPlayerNumber >= maxSubrounds && currentPlayerNumber == guesserPlayerNumber - 1){
      dev.log("game ended");
      state = state.copyWith.call(status: GameStatus.end);
    } else if(state.currentSubRound + 1 >= _gameSettings!.playersCount){
      state = state.copyWith.call(question: _randomQuestion(), currentRound: state.currentRound + 1, currentSubRound: 0, currentPlayerNumber: 2, guesserPlayerNumber: 1, realAnswers: [], guessedAnswers: [], status: GameStatus.answering);
    } else{
      state = state.copyWith.call(question: _randomQuestion(), currentSubRound: state.currentSubRound + 1, currentPlayerNumber: 1, guesserPlayerNumber: state.guesserPlayerNumber + 1, realAnswers: [], guessedAnswers: [], status: GameStatus.answering);
    }
    dev.log(state.toString());
  }
  void _nextPlayer(){
    state = state.copyWith.call(currentPlayerNumber: state.currentPlayerNumber + 1 == state.guesserPlayerNumber ? state.currentPlayerNumber + 2 : state.currentPlayerNumber + 1);
  }
}