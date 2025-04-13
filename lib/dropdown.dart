import 'package:flutter/material.dart';

/// Flutter code sample for [DropdownMenu].

class Dropdown extends StatefulWidget {
  final List<String> items;
  final String? initialSelection;
  final Function(String?) onChanged;
  final double width;
  final String placeholder;

  const Dropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.initialSelection,
    this.width = 300,
    required this.placeholder,
  });

  @override
  State<Dropdown> createState() => _DropdownState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _DropdownState extends State<Dropdown> {
  late List<MenuEntry> menuEntries;
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialSelection;

    menuEntries =
        widget.items
            .map<MenuEntry>(
              (String name) => MenuEntry(value: name, label: name),
            )
            .toList();
    //dropdownValue = widget.initialSelection ?? w  idget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: dropdownValue,
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
        widget.onChanged(value);
      },
      dropdownMenuEntries: menuEntries,
      width: 900,
      hintText: widget.placeholder,
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(
          Color.fromRGBO(212, 144, 112, 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color.fromRGBO(196, 108, 68, 0.3), // Cor do campo fechado
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}
