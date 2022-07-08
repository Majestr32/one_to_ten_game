import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_to_ten_game/providers/games_provider.dart';
import 'package:one_to_ten_game/providers/locale_provider.dart';
import 'package:one_to_ten_game/providers/one_to_ten_game_provider.dart';
import 'package:one_to_ten_game/repositories/games/games_repository.dart';
import 'package:one_to_ten_game/screens/one_to_ten/instruction.dart';
import 'package:one_to_ten_game/widgets/dropdown.dart';
import 'package:one_to_ten_game/widgets/home_game_tile.dart';
import 'package:one_to_ten_game/widgets/horizontal_line.dart';

import 'l10n/l10n.dart';
import 'models/game_info/game_info.dart';


void main() async{
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    return ProviderScope(
      overrides: [
        oneToTenGameProvider.overrideWithValue(OneToTenGameNotifier()),
        currentGameSettingsProvider.overrideWithValue(GameSettingsNotifier()),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizations.delegate
        ],
        routes: {
          "/1to10game": (context) => InstructionScreen()
        },
        locale: locale,
        supportedLocales: L10n.supported,
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(gamesRepositoryProvider).init(AppLocalizations.of(context)!);
    final gamesState = ref.watch(gamesProvider);
    final locale = ref.read(localeProvider.notifier);
    return Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: RadialGradient(colors: [Color(0xFF585858), Color(0xFF3D3D3D)])
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Align(alignment: Alignment.centerRight, child: Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Dropdown(items: ['Eng','De'], onItemChanged: (String item) async{
                        if(item == 'De'){
                          Locale german = Locale.fromSubtags(languageCode: 'de');
                          locale.state = german;
                        }else{
                          Locale english = Locale.fromSubtags(languageCode: 'en');
                          locale.state = english;
                        }
                      },)),),
                  SizedBox(height: 15,),
                  HorizontalLine(),
                  SizedBox(height: 5,),
                  HorizontalLine(),
                  SizedBox(height: 20,),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ListView.builder(
                              itemCount: gamesState.length,
                              shrinkWrap: true,
                              itemBuilder: (context, i){
                                return Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: HomeGameTile(routePath: gamesState[i].onClickRoutePath, title: gamesState[i].name, prefixSubtitle: AppLocalizations.of(context)!.game_players_count(gamesState[i].minPlayers.toString(), gamesState[i].maxPlayers.toString()), suffixSubtitle: gamesState[i].timeInfo, backgroundImageAssetUrl: gamesState[i].assetPath));
                              })
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }

}
