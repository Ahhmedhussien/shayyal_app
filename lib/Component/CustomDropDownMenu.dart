import 'package:flutter/material.dart';
import 'package:shyal/Screens/AddAddressScreen.dart';
import 'package:shyal/Screens/AddNewAddresWithMapScreen.dart';
import 'package:shyal/const.dart';
// Assume green_color and the list of addresses are defined in your 'const.dart' file.

class CustomDropdownFormField extends StatefulWidget {
  final List<String> items;
  final String hint;
  final BuildContext parentContext;
  final bool isAddress;
  final String defultValue;
  final Function(String) onSelected; // Callback to pass the selected value

  const CustomDropdownFormField({
    super.key,
    required this.items,
    required this.hint,
    required this.parentContext,
    this.isAddress = false,
    this.defultValue = '',
    required this.onSelected,
  });

  @override
  State<CustomDropdownFormField> createState() =>
      _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  String? selectedValue;
  @override
  void initState() {
    super.initState();
    // Set the initial selected value only if it's contained within the items list
    if (widget.items.contains(widget.defultValue)) {
      selectedValue = widget.defultValue;
    } else {
      // Optionally, set to the first item of the list or keep it null if the list is empty
      selectedValue = widget.items.isNotEmpty ? widget.items.first : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> menuItems =
        widget.items.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04)),
      );
    }).toList();

    if (widget.isAddress) {
      // Add 'Add Address' item only if it's used for address
      menuItems.add(const DropdownMenuItem<String>(
        value: "Add Address",
        child: Text("Add Address"),
      ));
    }

    return DropdownButtonFormField<String>(
      value: selectedValue,
      isExpanded: true,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      dropdownColor: const Color(0xff2F3B37),
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
            color: green_color,
          ),
        ),
        hintText: widget.hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xff2F3B37),
      ),
      onChanged: (String? newValue) {
        setState(() {
          if (widget.isAddress && newValue == "Add Address") {
            Navigator.of(widget.parentContext).push(MaterialPageRoute(
              builder: (context) => const AddAddressScreen(),
            ));
          } else {
            selectedValue = newValue;
          }
        });
        widget.onSelected(newValue!);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an option';
        }
        return null;
      },
      items: menuItems,
    );
  }
}
