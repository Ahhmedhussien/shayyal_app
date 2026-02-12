import 'package:flutter/material.dart';
import 'package:shyal/Widgets/BattomNavigationBar.dart';
import 'package:shyal/Widgets/HeaderHome.dart';
import 'package:shyal/Widgets/TruckingNumberWidget.dart';
import 'package:shyal/Widgets/TruckingWidget.dart';
import 'package:shyal/const.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double verticalSpacing = MediaQuery.of(context).size.height * 0.025;
    double sidePadding = MediaQuery.of(context).size.width * 0.05;
    double topPadding = MediaQuery.of(context).size.height * 0.03;

    return Scaffold(
      backgroundColor: background_color,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              top: topPadding, left: sidePadding, right: sidePadding),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const HomeHeader(),
              SizedBox(height: verticalSpacing),
              // const TruckingNumberWidget(),
              SizedBox(height: verticalSpacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Recent Delivery'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, '/OrderHistoryScreen');
                    },
                    child: const Text('View All',
                        style: TextStyle(color: green_color)),
                  )
                ],
              ),
              SizedBox(height: verticalSpacing),
              const TrackingWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/SendPackageScreen');
        },
        backgroundColor: Secound_green_color,
        child: const Icon(Icons.add),
      ),
    );
  }
}
