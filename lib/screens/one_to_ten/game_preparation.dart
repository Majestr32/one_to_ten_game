


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/consts/k_icons.dart';
import 'package:one_to_ten_game/models/game_settings/one_to_ten/game_settings.dart';
import 'package:one_to_ten_game/providers/games_provider.dart';
import 'package:one_to_ten_game/providers/one_to_ten_game_provider.dart';
import 'package:one_to_ten_game/screens/one_to_ten/loading_screen.dart';
import 'package:one_to_ten_game/screens/one_to_ten/question_choice.dart';
import 'package:one_to_ten_game/widgets/active_button.dart';
import 'package:one_to_ten_game/widgets/horizontal_line.dart';
import 'package:one_to_ten_game/widgets/player_display_box.dart';
import 'package:one_to_ten_game/widgets/rounded_dropdown.dart';
import 'package:one_to_ten_game/widgets/standart_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GamePreparation extends ConsumerWidget {
  GamePreparation({Key? key}) : super(key: key);

  List<String> playerNames = [
    "Player 1",
    "Player 2",
    "Player 3",
    "Player 4"
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(currentGameSettingsProvider);
    final settingsNotifier = ref.read(currentGameSettingsProvider.notifier);
    return Scaffold(
      appBar: StandartAppBar(title: AppLocalizations.of(context)!.title_game_preparation,),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                ListView.builder(
                    itemCount: settingsState.playersCount,
                    shrinkWrap: true,
                    itemBuilder: (context, i){
                      return Container(
                          margin: EdgeInsets.symmetric(vertical: 7),
                          child: PlayerDisplayBox(
                            onChanged: (s){
                              playerNames[i] = s;
                              log(playerNames.toString());
                            },
                            playerName: AppLocalizations.of(context)!.player_title((i+1).toString()), hasMinusButton: (i+1) > settingsState.info.minPlayers, onMinusClicked: (){
                            settingsNotifier.decrementPlayersCount();
                            playerNames.removeAt(i);
                          },));
                }),
                IconButton(onPressed: (){
                  settingsNotifier.incrementPlayersCount();
                  playerNames.add('Player ' + (settingsState.playersCount + 1).toString());
                }, icon: ImageIcon(KIcons.add.image, size: 36,)),
                SizedBox(height: 15,),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 1,
                    child: HorizontalLine()),
                SizedBox(height: 15,),
                _textAndDropdown(AppLocalizations.of(context)!.rounds_text, List.generate(settingsState.info.maxRounds - settingsState.info.minRounds + 1, (index) => (settingsState.info.minRounds + index).toString()), (item){
                  int currentRounds = int.parse(item!);
                  settingsNotifier.setRoundsNumber(currentRounds);
                }),
                SizedBox(height: 15,),
                _textAndDropdown(AppLocalizations.of(context)!.timelimit_text, ['-'], (item){}),
                SizedBox(height: 40,),
                ActiveButton(onPressed: () async{
                  if(playerNames.any((n) => n.trim().isEmpty || playerNames.toSet().length != playerNames.length) //if there`s no duplicates
                  ){
                    return;
                  }
                  log("settings: players " +  ref.read(currentGameSettingsProvider).playersCount.toString() + " , rounds " + ref.read(currentGameSettingsProvider).roundsCount.toString());
                  await ref.read(oneToTenGameProvider.notifier).init(ref.read(currentGameSettingsProvider), playerNames);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => QuestionChoice()));
                }, text: AppLocalizations.of(context)!.button_start),
                SizedBox(height: 15,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textAndDropdown(String title,List<String> items, Function(String?) onItemChanged){
    return Row(children: [
      Text(title, style: TextStyle(fontSize: 18, fontFamily: 'Bahn', fontWeight: FontWeight.bold),),
      Spacer(),
      RoundedDropdown(onItemChanged: onItemChanged, items: items)
    ],);
  }
}
