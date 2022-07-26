
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:one_to_ten_game/consts/k_colors.dart';
import 'package:one_to_ten_game/consts/k_icons.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart' as inset;

class PlayerDisplayBox extends HookWidget {
  final String hintText;
  final bool hasMinusButton;
  final Function(String) onChanged;
  final VoidCallback? onMinusClicked;
  const PlayerDisplayBox({required this.onChanged,required this.hintText, this.onMinusClicked, this.hasMinusButton = false,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = useTextEditingController.call(text: '');
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 49,
      decoration: inset.BoxDecoration(
        color: KColors.lightAccent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: KColors.mainAccent),
        boxShadow: [
          inset.BoxShadow(color: KColors.black.withOpacity(0.4), offset: Offset(0,3), blurRadius: 6, inset: true),
          inset.BoxShadow(color: KColors.black.withOpacity(0.16), offset: Offset(0,3), blurRadius: 6),
        ]
      ),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (s) => onChanged.call(s),
                      cursorColor: KColors.mainAccent,
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: TextStyle(color: KColors.black.withOpacity(0.32), fontSize: 18, fontFamily: 'Bahn', fontWeight: FontWeight.bold),
                        border: InputBorder.none
                      ),
                      controller: _controller,
                      style: TextStyle(color: KColors.black.withOpacity(0.32), fontSize: 18, fontFamily: 'Bahn', fontWeight: FontWeight.bold),),
                  ),
                  hasMinusButton ? SizedBox(
                      width: 46,
                      child: IconButton(onPressed: () => onMinusClicked?.call(), icon: ImageIcon(KIcons.minus.image))) : Container()
                ],
              ))),
    );
  }
}
