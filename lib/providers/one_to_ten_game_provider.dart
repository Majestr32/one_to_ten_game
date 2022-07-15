
import 'dart:math';
import 'dart:developer' as dev;

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/models/games_models/one_to_ten/game_manager.dart';
import 'package:one_to_ten_game/repositories/one_to_ten_games/questions_repository.dart';

import '../models/game_settings/one_to_ten/game_settings.dart';
import '../models/games_models/one_to_ten/answer.dart';
import '../models/games_models/one_to_ten/player.dart';


final oneToTenGameProvider = StateNotifierProvider<OneToTenGameNotifier, GameManager>((ref) => OneToTenGameNotifier());

class OneToTenGameNotifier extends StateNotifier<GameManager>{
  GameSettings? _gameSettings;
  OneToTenGameNotifier({GameSettings? gameSettings}) : super(GameManager()){
    _gameSettings = gameSettings;
  }

  Future<void> init(GameSettings gameSettings, List<String> playerNames) async{
    _gameSettings = gameSettings;
    //hardcoded because i am really tired
    final allQuestions = await QuestionsRepository().getQuestions();
    state = state.copyWith.call(allQuestions: allQuestions, players: List.generate(_gameSettings!.playersCount, (index) => Player(name: playerNames[index], score: 0)));
  }
  void submitAnswer(Answer answer){
    state = state.copyWith.call(realAnswers: [...state.realAnswers, answer]);
  }
  void editAnswer(Answer answer){
    final newAnswers = state.realAnswers.map((e){
      if(e.playerName == answer.playerName){
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
        if(realAnswer.playerName == guessedAnswer.playerName && realAnswer.answer == guessedAnswer.answer){
          scores += 2;
        }
      }
    }
    final guesser = state.players.firstWhere((pl) => pl.name == state.guesserPlayerName);
    state = state.copyWith.call(players: state.players.map((pl){
      if(pl.name == guesser.name){
        return Player(name: state.guesserPlayerName, score: guesser.score + scores);
      }else{
        return pl;
      }
    }).toList());
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
    final _random = Random();
    return state.allQuestions[_random.nextInt(state.allQuestions.length)];
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