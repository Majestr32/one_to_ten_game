import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/consts/k_icons.dart';
import 'package:one_to_ten_game/models/game_info/game_info.dart';
import 'package:one_to_ten_game/providers/games_provider.dart';
import 'package:one_to_ten_game/providers/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_to_ten_game/providers/one_to_ten_game_provider.dart';
import 'package:one_to_ten_game/screens/one_to_ten/game_preparation.dart';
import 'package:one_to_ten_game/widgets/active_button.dart';
import 'package:one_to_ten_game/widgets/standart_app_bar.dart';

import '../../models/game_settings/one_to_ten/game_settings.dart';

class InstructionScreen extends ConsumerStatefulWidget {
  const InstructionScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<InstructionScreen> createState() => _InstructionScreenState();
}

class _InstructionScreenState extends ConsumerState<InstructionScreen> {

  @override
  void initState() {
    super.initState();
    GameInfo gameInfo = ref.read(gamesRepositoryProvider).getGameByIdName('1_to_10');
    ref.read(currentGameSettingsProvider.notifier).init(GameSettings(info: gameInfo, playersCount: 4, roundsCount: 1));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StandartAppBar(title: 'Instruction'),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Text(AppLocalizations.of(context)!.title_instruction, textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontFamily: 'Bahn'),),
              ),
              Spacer(),
              ImageIcon(KIcons.instructions.image, size: 196,),
              Spacer(),
              ActiveButton(onPressed: () async{
                await ref.read(oneToTenGameProvider.notifier).init(ref.read(currentGameSettingsProvider));
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => GamePreparation()));
              }, text: AppLocalizations.of(context)!.button_skip),
              SizedBox(height: 20,)
            ],
          ),
        ));
  }
}
