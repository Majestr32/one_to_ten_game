import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/consts/k_colors.dart';
import 'package:one_to_ten_game/main.dart';
import 'package:one_to_ten_game/models/games_models/one_to_ten/player.dart';
import 'package:one_to_ten_game/widgets/active_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../providers/one_to_ten_game_provider.dart';

class PodestScreen extends ConsumerWidget {
  const PodestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          ((){
            final playersCopy = [...ref.watch(oneToTenGameProvider).players];
            playersCopy.sort((a,b) => b.score.compareTo(a.score));
            return Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  leaderBloc(context, playersCopy[1], MediaQuery.of(context).size.width * 0.25, MediaQuery.of(context).size.height * 0.55, 20 ,KColors.lightAccent),
                  leaderBloc(context, playersCopy[0], MediaQuery.of(context).size.width * 0.35, MediaQuery.of(context).size.height * 0.7, 22, KColors.mainAccent),
                  leaderBloc(context, playersCopy[2], MediaQuery.of(context).size.width * 0.25, MediaQuery.of(context).size.height * 0.5, 18,KColors.lightAccent),
                ],
              ),
            );
          }()),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 15),
                child: ActiveButton(text: AppLocalizations.of(context)!.button_menu, onPressed: (){
                  Navigator.of(context).pop();
          },),
              )),
        ],
      ),
    );
  }
  Widget leaderBloc(BuildContext context,Player player, double width, double height, double fontSize, Color color){
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          Container(
            width: width,
            height: 40,
            child: Center(
              child: Text(AppLocalizations.of(context)!.player_title(player.number.toString()), style: TextStyle(fontSize: fontSize, fontFamily: 'Bahn', fontWeight: FontWeight.normal),),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    color,
                    KColors.white
                  ]
                )
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(AppLocalizations.of(context)!.text_point_xy(player.score.toString()), style: TextStyle(fontSize: fontSize, fontFamily: 'Bahn', fontWeight: FontWeight.bold),),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
