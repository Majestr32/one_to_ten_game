
import 'package:flutter/material.dart';
import 'package:one_to_ten_game/consts/k_colors.dart';

class ActiveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const ActiveButton({required this.onPressed, required this.text,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 52,
      child: ElevatedButton(onPressed: onPressed, child: Text(text, style: TextStyle(fontSize: 24, fontFamily: 'Bahn', fontWeight: FontWeight.bold),), style: ElevatedButton.styleFrom(
        primary: KColors.mainAccent
      ),),
    );
  }
}
