import 'package:flutter/material.dart';
import 'package:one_to_ten_game/consts/k_colors.dart';
import 'package:one_to_ten_game/widgets/horizontal_line.dart';

import '../consts/k_icons.dart';

class StandartAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final bool hasBackButton;
  const StandartAppBar({required this.title, this.hasBackButton = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: HorizontalLine(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 22),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(title, style: TextStyle(fontSize: 32, fontFamily: 'LemonMilk', fontWeight: FontWeight.w400),),
            ),
          ),
          hasBackButton ? Align(alignment: Alignment.topLeft,
          child: IconButton(icon: Icon(KIcons.backButton), color: KColors.mainAccent,
          onPressed: (){
            Navigator.of(context).pop();
          },),) : Container()
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity,90);
}
