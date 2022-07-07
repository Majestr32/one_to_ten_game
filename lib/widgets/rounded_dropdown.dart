import 'package:flutter/material.dart';

import '../consts/k_colors.dart';

class RoundedDropdown extends StatefulWidget {
  final List<String> items;
  final Function(String item) onItemChanged;
  const RoundedDropdown({required this.onItemChanged,required this.items,Key? key}) : super(key: key);

  @override
  State<RoundedDropdown> createState() => _RoundedDropdownState();
}

class _RoundedDropdownState extends State<RoundedDropdown> {

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
      width: 55,
      height: 35,
      child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            fillColor: KColors.white,
            filled: true,
            focusColor: KColors.mainAccent,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: KColors.black),
                borderRadius: BorderRadius.circular(8),
                gapPadding: 0
            ),
            contentPadding: EdgeInsets.all(8),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: KColors.black),
                borderRadius: BorderRadius.circular(8),
                gapPadding: 0
            ),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: KColors.black),
                borderRadius: BorderRadius.circular(8),
                gapPadding: 0
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: KColors.black),
                borderRadius: BorderRadius.circular(8),
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
