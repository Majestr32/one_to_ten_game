import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/consts/k_colors.dart';
import 'package:one_to_ten_game/main.dart';
import 'package:one_to_ten_game/models/games_models/one_to_ten/player.dart';
import 'package:one_to_ten_game/widgets/active_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../providers/one_to_ten_game_provider.dart';

class PodestScreen extends ConsumerStatefulWidget {


  PodestScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PodestScreen> createState() => _PodestScreenState();
}

class _PodestScreenState extends ConsumerState<PodestScreen> {
  bool _visible3rd = false;
  bool _visible2nd = false;
  bool _visible1st = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 1)).then((_){
        setState((){
          _visible3rd = true;
        });
      });
      Future.delayed(Duration(seconds: 3)).then((_){
        setState((){
          _visible2nd = true;
        });
      });
      Future.delayed(Duration(seconds: 6)).then((_){
        setState((){
          _visible1st = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
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
                    AnimatedOpacity(
                        opacity: _visible2nd ? 1 : 0,
                        duration: Duration(seconds: 3),
                        child: leaderBloc(context, playersCopy[1], MediaQuery.of(context).size.width * 0.25, MediaQuery.of(context).size.height * 0.55, 20 ,KColors.lightAccent)),
                    AnimatedOpacity(
                        opacity: _visible1st ? 1.0 : 0,
                        duration: Duration(seconds: 2),
                        child: leaderBloc(context, playersCopy[0], MediaQuery.of(context).size.width * 0.35, MediaQuery.of(context).size.height * 0.7, 22, KColors.mainAccent)),
                    AnimatedOpacity(
                        opacity: _visible3rd ? 1.0 : 0,
                        duration: Duration(seconds: 2),
                        child: leaderBloc(context, playersCopy[2], MediaQuery.of(context).size.width * 0.25, MediaQuery.of(context).size.height * 0.5, 18,KColors.lightAccent)),
                  ],
                ),
              );
            }()),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: ActiveButton(text: AppLocalizations.of(context)!.button_menu, onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
            },),
                )),
          ],
        ),
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
              child: Text(player.name, style: TextStyle(fontSize: fontSize, fontFamily: 'Bahn', fontWeight: FontWeight.normal),),
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
