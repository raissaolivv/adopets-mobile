import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key});

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
         String formattedMonth = picked.month < 10 ? "0${picked.month}" : "${picked.month}";
        _dateController.text = "${picked.day}/$formattedMonth/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: TextField(
        controller: _dateController,
        decoration: InputDecoration(
          fillColor: Color.fromRGBO(196, 108, 68, 0.3),
          prefixIcon: Icon(Icons.calendar_today),
          labelText: "Escolha uma data",
          border: OutlineInputBorder(),
        ),
        readOnly: true,
        onTap: () => _selectDate(context),
      ),
    );
  }
}
