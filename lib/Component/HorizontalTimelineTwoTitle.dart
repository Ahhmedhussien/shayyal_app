import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

Widget HorizontalTimelineTwoTitle(
    BuildContext context, String title, String subtitle) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenheight = MediaQuery.of(context).size.height;
  final textSize = screenWidth * 0.04; // Dynamic text size for titles
  final timelinetileheight = screenheight * 0.1;

  return SizedBox(
    height: timelinetileheight,
    child: TimelineTile(
      axis: TimelineAxis.vertical,
      alignment: TimelineAlign.start,
      isFirst: title == 'From',
      isLast: title == 'Shipped To',
      indicatorStyle: const IndicatorStyle(
        width: 10,
        color: Colors.white,
        padding: EdgeInsets.only(left: 15),
      ),
      beforeLineStyle: const LineStyle(
        color: Colors.white54,
        thickness: 3,
      ),
      endChild: Padding(
        padding:
            EdgeInsets.only(left: screenWidth * 0.02, top: screenWidth * 0.02),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: textSize,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: textSize,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
