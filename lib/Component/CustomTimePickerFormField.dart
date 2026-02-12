import 'package:flutter/material.dart';
import 'package:shyal/const.dart';

class CustomTimePickerFormField extends StatefulWidget {
  final String hint;
  final Function(TimeOfDay) onTimeSelected;
  final TextEditingController controller;
  final TimeOfDay? defaultTime; // Optional default time

  const CustomTimePickerFormField(
      {super.key,
      required this.hint,
      required this.onTimeSelected,
      required this.controller,
      this.defaultTime});

  @override
  State<CustomTimePickerFormField> createState() =>
      _CustomTimePickerFormFieldState();
}

class _CustomTimePickerFormFieldState extends State<CustomTimePickerFormField> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    // Set default time if provided
    if (widget.defaultTime != null) {
      selectedTime = widget.defaultTime ?? TimeOfDay.now();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Now we can safely use context
    if (selectedTime != null && widget.controller.text.isEmpty) {
      widget.controller.text =
          selectedTime!.format(context); // Update text with context
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
      widget.onTimeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectTime(context),
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
              selectedTime == null
                  ? 'Enter Time'
                  : 'Picked Time: ${selectedTime!.format(context)}',
              style: TextStyle(
                  color: selectedTime == null ? Colors.white54 : Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
            const Icon(
              Icons.access_time,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
