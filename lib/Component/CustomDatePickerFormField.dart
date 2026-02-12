import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:shyal/const.dart';

class CustomDatePickerFormField extends StatefulWidget {
  final String hint;
  final Function(DateTime) onDateSelected; // Callback to pass the selected date
  final TextEditingController controller; // Add controller to the parameters
  final DateTime? defaultDate; // Optional default date

  const CustomDatePickerFormField(
      {super.key,
      required this.hint,
      required this.onDateSelected,
      required this.controller,
      this.defaultDate});

  @override
  State<CustomDatePickerFormField> createState() =>
      _CustomDatePickerFormFieldState();
}

class _CustomDatePickerFormFieldState extends State<CustomDatePickerFormField> {
  DateTime? selectedDate;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Set default date if provided
    if (widget.defaultDate != null) {
      selectedDate = widget.defaultDate;
      widget.controller.text = DateFormat.yMd().format(selectedDate!);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialEntryMode: DatePickerEntryMode.calendar,
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.controller.text = DateFormat.yMd().format(picked);
        _errorMessage = null;
      });
      widget.onDateSelected(picked);
    }
  }

  void validateDate() {
    if (widget.controller.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please select a date';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color:
                  green_color, // Replace with your green_color from const.dart
            ),
          ),
          hintText: widget.hint,
          hintStyle: const TextStyle(color: Colors.white54),
          filled: true,
          fillColor: Secound_background_color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              selectedDate == null
                  ? 'Enter Date'
                  : 'Picked Date: ${DateFormat.yMd().format(selectedDate!)}',
              style: TextStyle(
                  color: selectedDate == null ? Colors.white54 : Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
            const Icon(
              Icons.calendar_today,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
