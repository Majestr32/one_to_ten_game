
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/providers/one_to_ten_game_provider.dart';
import 'package:one_to_ten_game/screens/one_to_ten/game_summary.dart';
import 'package:one_to_ten_game/widgets/standart_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/games_models/one_to_ten/answer.dart';
import '../../widgets/active_button.dart';
import '../../widgets/player_answer_text_box.dart';

class EditAnswer extends ConsumerWidget {
  final String playerToEdit;
  final String previousAnswer;
  String enteredAnswer = "";

  EditAnswer({required this.playerToEdit, required this.previousAnswer,Key? key}) : super(key: key){
    enteredAnswer = previousAnswer;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameProviderNotifier = ref.read(oneToTenGameProvider.notifier);
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        appBar: StandartAppBar(title: AppLocalizations.of(context)!.title_edit_answer(playerToEdit)),
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(children: [
              Text(ref.watch(oneToTenGameProvider).question),
              Spacer(),
              PlayerAnswerTextBox(
                initialValue: previousAnswer,
                onChanged: (text) {enteredAnswer = text;},
              ),
              SizedBox(height: 25,),
              ActiveButton(onPressed: (){
                if(enteredAnswer.isEmpty){
                  return;
                }
                gameProviderNotifier.editAnswer(Answer(answer: enteredAnswer, playerName: playerToEdit));
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => GameSummary()));
              }, text: AppLocalizations.of(context)!.button_save),
              SizedBox(height: 15,),
            ],),
          ),
        ),
      ),
    );
  }
}
