import 'package:flutter/material.dart';
import 'package:one_to_ten_game/consts/k_colors.dart';

class Dropdown extends StatefulWidget {
  final List<String> items;
  final Function(String item) onItemChanged;
  const Dropdown({required this.onItemChanged,required this.items,Key? key}) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {

  late String _selectedItem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedItem = widget.items[0];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 35,
      child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            fillColor: KColors.white,
            filled: true,
            focusColor: KColors.mainAccent,
            focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: KColors.mainAccent),
          gapPadding: 0
      ),
            contentPadding: EdgeInsets.all(8),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: KColors.mainAccent),
                  gapPadding: 0
              ),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: KColors.mainAccent),
                gapPadding: 0
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: KColors.mainAccent),
                gapPadding: 0
            ),
          ),
          value: _selectedItem,
          items: List.generate(widget.items.length, (index) => DropdownMenuItem<String>(
              value: widget.items[index],
              child: Text(widget.items[index]))), onChanged: (item){
            setState((){
              _selectedItem = item ?? '';
            });
            widget.onItemChanged.call(item ?? '');
      }),
    );
  }
}
