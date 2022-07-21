
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/models/games_models/one_to_ten/game_manager.dart';
import 'package:one_to_ten_game/providers/one_to_ten_game_provider.dart';
import 'package:one_to_ten_game/screens/one_to_ten/game_summary.dart';
import 'package:one_to_ten_game/screens/one_to_ten/loading_screen.dart';
import 'package:one_to_ten_game/widgets/active_button.dart';
import 'package:one_to_ten_game/widgets/player_answer_text_box.dart';
import 'package:one_to_ten_game/widgets/standart_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/games_models/one_to_ten/answer.dart';

class GameWrapper extends ConsumerWidget {
  GameWrapper({Key? key}) : super(key: key);

  String enteredAnswer = "";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameProviderNotifier = ref.watch(oneToTenGameProvider.notifier);
    final gameProviderState = ref.watch(oneToTenGameProvider);
    return Scaffold(
      body: Scaffold(
        appBar: StandartAppBar(title: AppLocalizations.of(context)!.title_typing_player(gameProviderState.currentPlayerName),),
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(children: [
              Text(ref.watch(oneToTenGameProvider).question),
              Spacer(),
              PlayerAnswerTextBox(
                onChanged: (text) {enteredAnswer = text;},
              ),
              SizedBox(height: 25,),
              ActiveButton(onPressed: (){
                if(enteredAnswer.trim().isEmpty){
                  return;
                }else if(RegExp(r"[^a-z0-9 ]", caseSensitive: false).hasMatch(enteredAnswer)){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Only letters and numbers"),
                  ));
                  return;
                }
                gameProviderNotifier.submitAnswer(Answer(answer: enteredAnswer, playerName: gameProviderState.currentPlayerName));
                gameProviderNotifier.next();
                if(gameProviderState.status == GameStatus.lastQuestion){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => GameSummary()));
                  return;
                }
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoadingScreen()));
              }, text: gameProviderState.status == GameStatus.lastQuestion ? AppLocalizations.of(context)!.button_summarize : AppLocalizations.of(context)!.button_next),
              SizedBox(height: 15,),
            ],),
          ),
        )
      ),
    );
  }
}
