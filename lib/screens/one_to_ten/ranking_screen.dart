
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/consts/k_colors.dart';
import 'package:one_to_ten_game/models/games_models/one_to_ten/game_manager.dart';
import 'package:one_to_ten_game/providers/one_to_ten_game_provider.dart';
import 'package:one_to_ten_game/screens/one_to_ten/game_wrapper.dart';
import 'package:one_to_ten_game/screens/one_to_ten/podest_screen.dart';
import 'package:one_to_ten_game/screens/one_to_ten/question_choice.dart';
import 'package:one_to_ten_game/widgets/standart_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RankingScreen extends ConsumerStatefulWidget {
  const RankingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends ConsumerState<RankingScreen> {
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer(
        Duration(seconds: 4),
            () {
          ref.read(oneToTenGameProvider.notifier).nextSubround();
          if(ref.read(oneToTenGameProvider).status == GameStatus.end){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => PodestScreen()));
          }else{
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => QuestionChoice()));
          }
        });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandartAppBar(title: AppLocalizations.of(context)!.title_ranking,),
      body: Scaffold(
        body: ListView.builder(
            itemCount: ref.watch(oneToTenGameProvider).players.length,
            itemBuilder: (context, i){
              final playersCopy = [...ref.watch(oneToTenGameProvider).players];
              playersCopy.sort((a,b) => b.score.compareTo(a.score));
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(children: [
                  Text((i+1).toString(), style: TextStyle(fontSize: 32, fontFamily: 'LemonMilk', fontWeight: FontWeight.normal),),
                  Spacer(),
                  Text("\"" + playersCopy[i].name + "\"", style: TextStyle(fontSize: 32, fontFamily: 'LemonMilk', fontWeight: FontWeight.normal),),
                  Spacer(),
                  Text(playersCopy[i].score.toString() + " P.", style: TextStyle(fontSize: 32, fontFamily: 'LemonMilk', fontWeight: FontWeight.normal, color: i == 0 ? KColors.mainAccent : KColors.lightAccent),),
                ],),
              );
        })
      ),
    );
  }
}
