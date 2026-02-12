import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shyal/const.dart';

class GenderSelector extends StatefulWidget {
  final Function(int) onGenderChanged;
  final Gender? initialGender;
  const GenderSelector(
      {super.key, required this.onGenderChanged, required this.initialGender});

  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  Gender? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.initialGender ??
        Gender
            .male; // Initialize with the passed initialGender or default to male
  }

  Widget _buildGenderOption(Gender gender, IconData icon) {
    final bool isSelected = _selectedGender == gender;
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth > 600 ? 30.0 : 20.0;
    double verticalPadding = screenWidth > 600 ? 15.0 : 10.0;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          _selectedGender = gender;
          widget.onGenderChanged(_selectedGender == Gender.male ? 1 : 2);
        }),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
          decoration: BoxDecoration(
            color: background_color,
            border: Border.all(color: isSelected ? green_color : Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                gender == Gender.male ? "Male" : "Female",
                style: TextStyle(
                    fontSize: screenWidth > 600 ? 18 : 14, color: Colors.white),
              ),
              Icon(
                icon,
                color: isSelected ? green_color : Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildGenderOption(Gender.male, Icons.male_outlined),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        _buildGenderOption(Gender.female, Icons.female_outlined),
      ],
    );
  }
}
