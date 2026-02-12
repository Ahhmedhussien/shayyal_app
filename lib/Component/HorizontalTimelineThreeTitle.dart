import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class HorizontalTimelineThreeTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final String phonenumber;
  final bool isfirst;
  final bool islast;

  const HorizontalTimelineThreeTitle(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.phonenumber,
      required this.isfirst,
      required this.islast});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    final textSize = screenWidth * 0.04; // Dynamic text size for titles
    final timelinetileheight = screenheight * 0.1;

    return SizedBox(
      height: timelinetileheight,
      child: TimelineTile(
        axis: TimelineAxis.vertical,
        alignment: TimelineAlign.start,
        isFirst: isfirst,
        isLast: islast,
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
          padding: EdgeInsets.only(
              left: screenWidth * 0.02, top: screenWidth * 0.02),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
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
              Text(
                phonenumber,
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
}
