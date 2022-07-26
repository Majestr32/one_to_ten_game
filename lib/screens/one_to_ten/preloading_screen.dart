
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/consts/k_colors.dart';
import 'package:one_to_ten_game/providers/one_to_ten_game_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_to_ten_game/screens/one_to_ten/question_choice.dart';

class PreloadingScreen extends ConsumerStatefulWidget {
  PreloadingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PreloadingScreen> createState() => _PreloadingScreenState();
}

class _PreloadingScreenState extends ConsumerState<PreloadingScreen> {
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer(
        Duration(seconds: 5),
            () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => QuestionChoice()));
        });
  }
  @override
  Widget build(BuildContext context) {
    final oneToTenGame = ref.read(oneToTenGameProvider);
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: Text.rich(
                  TextSpan(text: oneToTenGame.guesserPlayerName + " ",  style: TextStyle(fontSize: 32, fontFamily: 'LemonMilk', color: KColors.mainAccent),
                  children: [
                    TextSpan(text: AppLocalizations.of(context)!.title_player_guesses(oneToTenGame.guesserPlayerName).split(" ").last, style: TextStyle(color: KColors.black))
                  ]), textAlign: TextAlign.center,)),
                Flexible(child: Text(
                  AppLocalizations.of(context)!.text_load_page(oneToTenGame.guesserPlayerName),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontFamily: 'Bahn'),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
