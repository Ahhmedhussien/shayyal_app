import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shyal/const.dart';

class PackageSizeWidget extends StatelessWidget {
  const PackageSizeWidget(
      {super.key,
      required this.icon,
      required this.label,
      this.isSelected = false,
      this.onTap});

  final String icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    double paddingSize =
        MediaQuery.of(context).size.width * 0.04; // 4% of screen width

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(paddingSize),
        decoration: BoxDecoration(
          color: isSelected ? green_color : Colors.white,
          border: Border.all(color: isSelected ? green_color : Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: SvgPicture.asset(icon,
                    colorFilter: ColorFilter.mode(
                        isSelected ? green_color : Colors.white,
                        BlendMode.srcIn))),
            SizedBox(height: paddingSize),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? green_color : Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
