
import 'dart:math';

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
  const GamePreparation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.read(currentGameSettingsProvider);
    final settingsNotifier = ref.read(currentGameSettingsProvider.notifier);
    return Scaffold(
      appBar: StandartAppBar(title: AppLocalizations.of(context)!.title_game_preparation,),
      body: Center(
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
                        child: PlayerDisplayBox(playerName: AppLocalizations.of(context)!.player_title((i+1).toString()), hasMinusButton: (i+1) > settingsState.info.minPlayers, onMinusClicked: (){
                          settingsNotifier.decrementPlayersCount();
                        },));
              }),
              IconButton(onPressed: (){
                settingsNotifier.incrementPlayersCount();
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
              Spacer(),
              ActiveButton(onPressed: () async{
                ref.read(oneToTenGameProvider.notifier).init(ref.read(currentGameSettingsProvider));
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuestionChoice()));
              }, text: AppLocalizations.of(context)!.button_start),
              SizedBox(height: 15,),
            ],
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
