
import 'package:flutter/material.dart';
import 'package:one_to_ten_game/consts/k_colors.dart';

class QuestionTile extends StatelessWidget {
  final String question;
  final VoidCallback onTap;
  const QuestionTile({required this.question, required this.onTap,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: KColors.mainAccent
          )
        ),
        child: Center(
          child: Text(question, style: TextStyle(fontSize: 18, fontFamily: 'Bahn'), textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}
