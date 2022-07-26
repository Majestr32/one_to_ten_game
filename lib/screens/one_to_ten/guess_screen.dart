import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/providers/one_to_ten_game_provider.dart';
import 'package:one_to_ten_game/screens/one_to_ten/evaluation_screen.dart';
import 'package:one_to_ten_game/screens/one_to_ten/loading_screen.dart';
import 'package:one_to_ten_game/widgets/player_dropdown_name_box.dart';
import 'package:one_to_ten_game/widgets/standart_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/games_models/one_to_ten/answer.dart';
import '../../widgets/active_button.dart';
import '../../widgets/horizontal_line.dart';
import '../../widgets/player_answer_text_box.dart';

class GuessScreen extends ConsumerStatefulWidget {
  GuessScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<GuessScreen> createState() => _GuessScreenState();
}

class _GuessScreenState extends ConsumerState<GuessScreen> {
  List<Answer> guesses = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    guesses = List.generate(ref.read(oneToTenGameProvider).players.length - 1, (index) => Answer(playerName: '', answer: "-"));
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return true;
      },
      child: Scaffold(
          appBar: StandartAppBar(title: AppLocalizations.of(context)!.title_player_guesses(ref.watch(oneToTenGameProvider).guesserPlayerName),),
          body: SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Text(ref.watch(oneToTenGameProvider).question),
                    SizedBox(height: 20,),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 1,
                        child: HorizontalLine()),
                    SizedBox(height: 15,),
                    ((){
                      final realAnswersCopy = [...ref.watch(oneToTenGameProvider).realAnswers];
                      realAnswersCopy.shuffle();
                      return ListView.builder(
                          itemCount: ref.watch(oneToTenGameProvider).realAnswers.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i){
                            return Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  children: [
                                    PlayerDropdownNameBox(guesserNumber: ref.watch(oneToTenGameProvider).guesserPlayerNumber, onItemChanged: (val){
                                      guesses[i] = Answer(playerName: val, answer: realAnswersCopy[i].answer);
                                    }, totalPlayersCount: ref.watch(oneToTenGameProvider).players.length),
                                    SizedBox(height: 5,),
                                    PlayerAnswerTextBox(playerName: realAnswersCopy[i].playerName, initialValue: realAnswersCopy[i].answer, readOnly: true,),
                                  ],
                                ));
                          });
                    }()),
                    SizedBox(height: 50,),
                    ActiveButton(onPressed: (){
                      if(guesses.any((ans) => ans.answer == "-")){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Your answers mustn`t be empty"),
                        ));
                        return;
                      }
                      ref.read(oneToTenGameProvider.notifier).submitGuesses(guesses);
                      ref.read(oneToTenGameProvider.notifier).calculateScores();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => EvaluationScreen()));
                    }, text: AppLocalizations.of(context)!.button_confirm,),
                    SizedBox(height: 15,),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
