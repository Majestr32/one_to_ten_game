
import 'package:flutter/material.dart';
import 'package:one_to_ten_game/consts/k_colors.dart';
import 'package:one_to_ten_game/consts/k_icons.dart';

class PlayerDisplayBox extends StatelessWidget {
  final String playerName;
  final bool hasMinusButton;
  final VoidCallback? onMinusClicked;
  const PlayerDisplayBox({required this.playerName, this.onMinusClicked, this.hasMinusButton = false,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 49,
      decoration: BoxDecoration(
        color: KColors.lightAccent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: KColors.mainAccent),
        boxShadow: [
          BoxShadow(color: KColors.black.withOpacity(0.16), offset: Offset(0,3), blurRadius: 6),
          BoxShadow(color: KColors.black.withOpacity(0.16), offset: Offset(0,3), blurRadius: 6, spreadRadius: -12)
        ]
      ),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text(playerName, style: TextStyle(color: KColors.black.withOpacity(0.32), fontSize: 18, fontFamily: 'Bahn', fontWeight: FontWeight.bold),),
                  Spacer(),
                  hasMinusButton ? IconButton(onPressed: () => onMinusClicked?.call(), icon: ImageIcon(KIcons.minus.image)) : Container()
                ],
              ))),
    );
  }
}
