import 'package:flutter/material.dart';
import 'package:one_to_ten_game/widgets/horizontal_line.dart';

class StandartAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const StandartAppBar({required this.title,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: HorizontalLine(),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(title, style: TextStyle(fontSize: 32, fontFamily: 'LemonMilk', fontWeight: FontWeight.w400),),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity,90);
}
