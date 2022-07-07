
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:one_to_ten_game/consts/k_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_to_ten_game/consts/k_icons.dart';
import 'package:one_to_ten_game/screens/one_to_ten/edit_answer.dart';

class PlayerAnswerTextBox extends HookWidget {
  final bool readOnly;
  final String? initialValue;
  final int? playerNumber;
  final bool hasEditIcon;
  final VoidCallback? onEditIconClicked;
  final Function(String)? onChanged;

  PlayerAnswerTextBox({this.playerNumber, this.hasEditIcon = false, this.readOnly = false, this.onChanged, this.initialValue, this.onEditIconClicked, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = useTextEditingController.call(text: initialValue);
    return Stack(
      children: [
        TextField(
          onChanged: (text) => onChanged?.call(text),
          enabled: !readOnly,
          controller: _controller,
          textAlignVertical: TextAlignVertical.center,
          maxLines: readOnly ? 4 : 6,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.answer_textfield,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: KColors.mainAccent,
                    width: 2
                )
            ),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: KColors.mainAccent,
                    width: 2
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: KColors.mainAccent,
                    width: 2
                )
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: KColors.mainAccent,
                width: 2
              )
            )
          ),
        ),
        hasEditIcon ? InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditAnswer(playerNumberToEdit: playerNumber!))),
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
                padding: EdgeInsets.only(right: 8, top: 8),
                child: Container(
                    width: 26,
                    height: 26,
                    child: KIcons.edit)),
          ),
        ) : Container(),
      ],
    );
  }
}
