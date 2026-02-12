import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shyal/const.dart';

class PackageSizeSelector extends StatefulWidget {
  final Function(int) onSelectionChanged; // Callback function
  const PackageSizeSelector({super.key, required this.onSelectionChanged});

  @override
  _PackageSizeSelectorState createState() => _PackageSizeSelectorState();
}

class _PackageSizeSelectorState extends State<PackageSizeSelector> {
  int selectedPackageSizeIndex = 0;

  @override
  void initState() {
    super.initState();
    // Trigger the selection callback for the initial default item
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onSelectionChanged(selectedPackageSizeIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double iconSize = MediaQuery.of(context).size.width * 0.17;
    double labelSpacing = MediaQuery.of(context).size.height * 0.01;
    double containerPadding = MediaQuery.of(context).size.width * 0.02;

    final List<Map<String, dynamic>> packageSizes = [
      {'label': '>750 KG', 'icon': 'assets/icons/1.svg'},
      {'label': '750KG - 2000KG', 'icon': 'assets/icons/2.svg'},
      {'label': '>2000 KG', 'icon': 'assets/icons/3.svg'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(packageSizes.length, (index) {
        bool isSelected = index == selectedPackageSizeIndex;
        return InkWell(
          onTap: () {
            setState(() {
              selectedPackageSizeIndex = index;
            });
            widget.onSelectionChanged(index);
          },
          child: Container(
            padding: EdgeInsets.all(containerPadding),
            decoration: BoxDecoration(
              color: background_color,
              border: Border.all(
                color: isSelected ? green_color : Colors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                SvgPicture.asset(
                  packageSizes[index]['icon'],
                  color: Colors.white,
                  width: iconSize, // Fixed width for the SVG icon
                  height: iconSize, // Fixed height for the SVG icon
                ),
                SizedBox(height: labelSpacing), // Space between icon and label
                Text(
                  packageSizes[index]['label'],
                  style: TextStyle(
                    fontSize:
                        screenWidth * 0.04, // Font size as 4% of screen width
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
