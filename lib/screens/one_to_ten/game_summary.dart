import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/providers/one_to_ten_game_provider.dart';
import 'package:one_to_ten_game/widgets/horizontal_line.dart';
import 'package:one_to_ten_game/widgets/player_name_box.dart';
import 'package:one_to_ten_game/widgets/standart_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/active_button.dart';
import '../../widgets/player_answer_text_box.dart';
import 'loading_screen.dart';

class GameSummary extends ConsumerWidget {
  const GameSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        appBar: StandartAppBar(title: AppLocalizations.of(context)!.title_answer_summary,),
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
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i){
                    return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            PlayerNameBox(playerName: ref.watch(oneToTenGameProvider).realAnswers[i].playerName),
                            SizedBox(height: 5,),
                            PlayerAnswerTextBox(playerName: ref.watch(oneToTenGameProvider).realAnswers[i].playerName, hasEditIcon: true ,initialValue: ref.watch(oneToTenGameProvider).realAnswers[i].answer, readOnly: true,),
                          ],
                        ));
                  }),
                  SizedBox(height: 50,),
                  ActiveButton(onPressed: (){
                    ref.read(oneToTenGameProvider.notifier).next();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoadingScreen()));
                  }, text: AppLocalizations.of(context)!.button_save,),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
