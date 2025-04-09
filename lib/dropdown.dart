import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// Flutter code sample for [DropdownMenu].

class Dropdown extends StatefulWidget {
  final List<String> items;
  final String? initialSelection;
  final Function(String?) onChanged;
  final double width;

  const Dropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.initialSelection,
    this.width = 300,
  });

  @override
  State<Dropdown> createState() => _DropdownState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _DropdownState extends State<Dropdown> {
  late List<MenuEntry> menuEntries;
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    menuEntries = widget.items.map<MenuEntry>((String name) => MenuEntry(value: name, label: name)).toList();
    dropdownValue = widget.initialSelection ?? widget.items.first;
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
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(
          Color.fromRGBO(196, 108, 68, 1),
        ),
      ),
    );
  }
}