
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../consts/k_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayerDropdownNameBox extends ConsumerStatefulWidget {
  final int totalPlayersCount;
  final int guesserNumber;
  final Function(String item) onItemChanged;
  const PlayerDropdownNameBox({required this.guesserNumber, required this.onItemChanged, required this.totalPlayersCount,Key? key}) : super(key: key);

  @override
  ConsumerState<PlayerDropdownNameBox> createState() => _PlayerDropdownNameBoxState();
}

class _PlayerDropdownNameBoxState extends ConsumerState<PlayerDropdownNameBox> {
  late String _selectedItem;
  late List<String> _choices;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _choices = List.generate(widget.totalPlayersCount, (index) => (index + 1).toString());
    _choices.removeAt(widget.guesserNumber - 1);
    _choices = ["-", ..._choices];
    _selectedItem = _choices.first;
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 35,
      child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            fillColor: KColors.white,
            filled: true,
            focusColor: KColors.mainAccent,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: KColors.black),
                gapPadding: 0
            ),
            contentPadding: EdgeInsets.all(8),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: KColors.black),
                gapPadding: 0
            ),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: KColors.black),
                gapPadding: 0
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: KColors.black),
                gapPadding: 0
            ),
          ),
          value: _selectedItem,
          items: List.generate(_choices.length, (index) => DropdownMenuItem<String>(
              value: _choices[index],
              child: Text(isNumeric(_choices[index]) ?
              AppLocalizations.of(context)!.player_title(_choices[index]) :
              _choices[index]))), onChanged: (item){
        setState((){
          _selectedItem = item ?? '';
        });
        widget.onItemChanged.call(item ?? '');
      }),
    );
  }
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
