import 'package:flutter/material.dart';
import 'package:one_to_ten_game/consts/k_colors.dart';

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 5,
      color: KColors.mainAccent,
    );
  }
}
