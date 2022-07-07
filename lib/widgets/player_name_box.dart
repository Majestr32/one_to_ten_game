
import 'package:flutter/material.dart';
import 'package:one_to_ten_game/consts/k_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayerNameBox extends StatelessWidget {
  final int playerNumber;
  final Image? suffixIconImage;
  const PlayerNameBox({required this.playerNumber, this.suffixIconImage,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: KColors.black)
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              Text(AppLocalizations.of(context)!.player_title(playerNumber.toString()), style: TextStyle(fontSize: 18, fontFamily: 'Bohn', fontWeight: FontWeight.bold),),
              Spacer(),
              suffixIconImage == null ? Container() : ImageIcon(suffixIconImage!.image, size: 24,)
            ],
          )),
    );
  }
}
