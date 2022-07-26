


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/consts/k_colors.dart';
import 'package:one_to_ten_game/consts/k_icons.dart';
import 'package:one_to_ten_game/models/game_settings/one_to_ten/game_settings.dart';
import 'package:one_to_ten_game/providers/games_provider.dart';
import 'package:one_to_ten_game/providers/one_to_ten_game_provider.dart';
import 'package:one_to_ten_game/screens/one_to_ten/loading_screen.dart';
import 'package:one_to_ten_game/screens/one_to_ten/preloading_screen.dart';
import 'package:one_to_ten_game/screens/one_to_ten/question_choice.dart';
import 'package:one_to_ten_game/widgets/active_button.dart';
import 'package:one_to_ten_game/widgets/horizontal_line.dart';
import 'package:one_to_ten_game/widgets/player_display_box.dart';
import 'package:one_to_ten_game/widgets/rounded_dropdown.dart';
import 'package:one_to_ten_game/widgets/standart_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GamePreparation extends ConsumerStatefulWidget {
  GamePreparation({Key? key}) : super(key: key);

  @override
  ConsumerState<GamePreparation> createState() => _GamePreparationState();
}

class _GamePreparationState extends ConsumerState<GamePreparation> {


  List<String> playerNames = [];
  bool _showInfo = false;
  final double _navbarSizeY = 90;
  GlobalKey _infoIconKey = GlobalKey();
  Offset? _infoWindowOffset;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      playerNames = List.generate(ref.read(currentGameSettingsProvider).playersCount, (index) => AppLocalizations.of(context)!.player_title((index + 1).toString()));
    });
  }

  void _recalculateWindowOffset(){
    RenderBox box = _infoIconKey.currentContext!.findRenderObject() as RenderBox;
    _infoWindowOffset = box.localToGlobal(Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(currentGameSettingsProvider);
    final settingsNotifier = ref.read(currentGameSettingsProvider.notifier);
    return Scaffold(
      appBar: StandartAppBar(title: AppLocalizations.of(context)!.title_game_preparation, hasBackButton: true,),
      body: Stack(
        children: [
          GestureDetector(
            onTap: (){
              setState((){
                _showInfo = false;
              });
            },
            child: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: [
                      ListView.builder(
                          itemCount: settingsState.playersCount,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, i){
                            return Container(
                                margin: EdgeInsets.symmetric(vertical: 7),
                                child: PlayerDisplayBox(
                                  onChanged: (s){
                                    playerNames[i] = s;
                                    log(playerNames.toString());
                                  },
                                  hintText: AppLocalizations.of(context)!.player_title((i+1).toString()), hasMinusButton: (i+1) > settingsState.info.minPlayers, onMinusClicked: (){
                                  settingsNotifier.decrementPlayersCount();
                                  playerNames.removeAt(i);
                                },));
                      }),
                      IconButton(onPressed: (){
                        settingsNotifier.incrementPlayersCount();
                        playerNames.add(AppLocalizations.of(context)!.player_title((settingsState.playersCount + 1).toString()));
                      }, icon: ImageIcon(KIcons.add.image, size: 36,)),
                      SizedBox(height: 15,),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 1,
                          child: HorizontalLine()),
                      SizedBox(height: 15,),
                      _textAndDropdown(
                          AppLocalizations.of(context)!.rounds_text, List.generate(settingsState.info.maxRounds - settingsState.info.minRounds + 1, (index) => (settingsState.info.minRounds + index).toString()), (item){
                        int currentRounds = int.parse(item!);
                        settingsNotifier.setRoundsNumber(currentRounds);
                      }, prefixWidget: IconButton(
                        key: _infoIconKey,
                          onPressed: (){
                          setState((){
                            _recalculateWindowOffset();
                            _showInfo = !_showInfo;
                          });
                      }, icon: ImageIcon(KIcons.info.image))),
                      SizedBox(height: 15,),
                      _textAndDropdown(AppLocalizations.of(context)!.timelimit_text, ['-'], (item){}),
                      SizedBox(height: 40,),
                      ActiveButton(onPressed: () async{
                        if(playerNames.any((n) => n.trim().isEmpty || playerNames.toSet().length != playerNames.length || n.contains(RegExp(r'[0-9]'))) //if there`s no duplicates
                        ){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Names must be not empty and contain only letters"),
                          ));
                          return;
                        }
                        await ref.read(oneToTenGameProvider.notifier).init(ref.read(currentGameSettingsProvider), playerNames);
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => PreloadingScreen()), (Route<dynamic> route) => false);
                      }, text: AppLocalizations.of(context)!.button_start),
                      SizedBox(height: 15,),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _showInfo ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: KColors.black),
              color: KColors.white,
            ),
            margin: EdgeInsets.only(top: _infoWindowOffset!.dy - _navbarSizeY - 180, left: _infoWindowOffset!.dx - 180) ,width: 200, height: 150,
          child: Center(child: Text('A round is over when each player has guessed once', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontFamily: 'Bahn'),),),) : Container()
        ],
      ),
    );
  }

  Widget _textAndDropdown(String title,List<String> items, Function(String?) onItemChanged,
      {Widget? prefixWidget}){
    return Row(children: [
      Text(title, style: TextStyle(fontSize: 18, fontFamily: 'Bahn', fontWeight: FontWeight.bold),),
      Spacer(),
      RoundedDropdown(onItemChanged: onItemChanged, items: items),
      prefixWidget ?? SizedBox(width: 48,)
    ],);
  }
}
