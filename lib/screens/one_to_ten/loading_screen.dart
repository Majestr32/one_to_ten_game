import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/consts/k_colors.dart';
import 'package:one_to_ten_game/models/games_models/one_to_ten/game_manager.dart';
import 'package:one_to_ten_game/providers/one_to_ten_game_provider.dart';
import 'package:one_to_ten_game/screens/one_to_ten/game_wrapper.dart';
import 'package:one_to_ten_game/screens/one_to_ten/guess_screen.dart';
import 'package:one_to_ten_game/widgets/standart_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoadingScreen extends ConsumerStatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {

  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer(
        Duration(seconds: 2),
            () {
          if(ref.watch(oneToTenGameProvider).status == GameStatus.guessing){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => GuessScreen()));
          }else{
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => GameWrapper()));
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
      appBar: StandartAppBar(title: AppLocalizations.of(context)!.title_player_guesses(ref.watch(oneToTenGameProvider).guesserPlayerName)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: LinearProgressIndicator(
                backgroundColor: KColors.grey,
                color: KColors.black,
                minHeight: 11,
              ),
            ),
            SizedBox(height: 20,),
            Text(ref.watch(oneToTenGameProvider).status == GameStatus.guessing ?
            AppLocalizations.of(context)!.text_load_page(ref.watch(oneToTenGameProvider.notifier).state.guesserPlayerName) :
            AppLocalizations.of(context)!.text_load_page(ref.watch(oneToTenGameProvider.notifier).state.currentPlayerName), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Bahn'),)
          ],
        ),
      ),
    );
  }
}
