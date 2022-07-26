
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/consts/k_colors.dart';
import 'package:one_to_ten_game/models/games_models/one_to_ten/game_manager.dart';
import 'package:one_to_ten_game/providers/one_to_ten_game_provider.dart';
import 'package:one_to_ten_game/screens/one_to_ten/game_wrapper.dart';
import 'package:one_to_ten_game/screens/one_to_ten/podest_screen.dart';
import 'package:one_to_ten_game/screens/one_to_ten/preloading_screen.dart';
import 'package:one_to_ten_game/screens/one_to_ten/question_choice.dart';
import 'package:one_to_ten_game/widgets/standart_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/active_button.dart';

class RankingScreen extends ConsumerStatefulWidget {
  const RankingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends ConsumerState<RankingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        appBar: StandartAppBar(title: AppLocalizations.of(context)!.title_ranking,),
        body: Scaffold(
          body: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
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
                        Text(playersCopy[i].score.toString() + " P.", style: TextStyle(fontSize: 32, fontFamily: 'LemonMilk', fontWeight: FontWeight.normal, color: Color.lerp(KColors.mainAccent, KColors.lightAccent, 1 * (i + 1) / ref.watch(oneToTenGameProvider).players.length)),),
                      ],),
                    );
              }),
              Spacer(),
              ActiveButton(onPressed: (){
                ref.read(oneToTenGameProvider.notifier).nextSubround();
                if(ref.read(oneToTenGameProvider).status == GameStatus.end){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => PodestScreen()));
                }else{
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => PreloadingScreen()));
                }
              }, text: AppLocalizations.of(context)!.button_next,),
              TextButton(onPressed: (){
                _showConfirmationModal();
              }, child: Text(AppLocalizations.of(context)!.button_end_game, style: TextStyle(color: KColors.black, decoration: TextDecoration.underline),)),
              SizedBox(height: 15,),
            ],
          )
        ),
      ),
    );
  }

  void _showConfirmationModal(){
    showDialog(context: context, builder: (context) => Dialog(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(36)
      ),
      child: SizedBox(
        width: 200,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Text(AppLocalizations.of(context)!.end_game_question, textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontFamily: 'Bahn', ),)),
            SizedBox(height: 5,),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: Text(AppLocalizations.of(context)!.button_no, style: TextStyle(color: KColors.white, fontSize: 18, fontFamily: 'Bahn')), style: ElevatedButton.styleFrom(
                      primary: KColors.mainAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36)),
                        side: BorderSide(color: KColors.grey),
                      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap
                  ),),
                ),
                Expanded(
                  child: ElevatedButton(onPressed: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => PodestScreen()));
                  }, child: Text(AppLocalizations.of(context)!.button_yes, style: TextStyle(color: KColors.black, fontSize: 18, fontFamily: 'Bahn'),), style: ElevatedButton.styleFrom(
                      primary: KColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(36)),
                        side: BorderSide(color: KColors.grey),
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap
                  ), ),
                ),
              ],),
          ],
        ),
      ),
    ));
  }
}
