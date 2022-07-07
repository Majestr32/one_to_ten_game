
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/consts/k_icons.dart';
import 'package:one_to_ten_game/providers/one_to_ten_game_provider.dart';
import 'package:one_to_ten_game/screens/one_to_ten/ranking_screen.dart';
import 'package:one_to_ten_game/widgets/player_answer_text_box.dart';
import 'package:one_to_ten_game/widgets/standart_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/active_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/horizontal_line.dart';
import '../../widgets/player_name_box.dart';

class EvaluationScreen extends ConsumerWidget {
  const EvaluationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: StandartAppBar(title: AppLocalizations.of(context)!.title_evaluation,),
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
                ListView.builder(
                    itemCount: ref.watch(oneToTenGameProvider).realAnswers.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i){
                      return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              PlayerNameBox(playerNumber: ref.watch(oneToTenGameProvider).realAnswers[i].playerNumber),
                              SizedBox(height: 5,),
                              PlayerNameBox(playerNumber: ref.watch(oneToTenGameProvider).guessedAnswers.firstWhere((ans) => ans.answer == ref.watch(oneToTenGameProvider).realAnswers[i].answer).playerNumber,
                              suffixIconImage: ref.watch(oneToTenGameProvider).guessedAnswers.any((ans) => ans.playerNumber == ref.watch(oneToTenGameProvider).realAnswers[i].playerNumber
                              && ans.answer == ref.watch(oneToTenGameProvider).realAnswers[i].answer) ? KIcons.tick : KIcons.cross,),
                              SizedBox(height: 5,),
                              PlayerAnswerTextBox(playerNumber: ref.watch(oneToTenGameProvider).realAnswers[i].playerNumber, initialValue: ref.watch(oneToTenGameProvider).realAnswers[i].answer, readOnly: true,),
                            ],
                          ));
                    }),
                SizedBox(height: 15,),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 1,
                    child: HorizontalLine()),
                SizedBox(height: 15,),
                ((){
                  int scores = 0;
                  for(var realAnswer in ref.read(oneToTenGameProvider).realAnswers){
                    for(var guessedAnswer in ref.read(oneToTenGameProvider).guessedAnswers){
                      if(realAnswer.playerNumber == guessedAnswer.playerNumber && realAnswer.answer == guessedAnswer.answer){
                        scores += 2;
                      }
                    }
                  }
                  return Text(AppLocalizations.of(context)!.text_point_xy(scores.toString()), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Bahn'),);
                }()),
                SizedBox(height: 15,),
                ActiveButton(onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RankingScreen()));
                }, text: AppLocalizations.of(context)!.button_next,),
                SizedBox(height: 15,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
