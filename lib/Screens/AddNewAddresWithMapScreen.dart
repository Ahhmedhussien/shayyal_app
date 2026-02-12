import 'package:flutter/material.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/Component/CustomTextFormField.dart';
import 'package:shyal/Widgets/PickMap.dart';
import 'package:shyal/const.dart';

class AddNewAddresWithMapScreen extends StatelessWidget {
  const AddNewAddresWithMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _houseController = TextEditingController();
    final _cityController = TextEditingController();
    final _streetController = TextEditingController();

    final EdgeInsets padding =
        EdgeInsets.all(MediaQuery.of(context).size.width * 0.05);

    return Scaffold(
      backgroundColor: background_color,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: PickMap(padding: padding),
            ),
            Container(
              padding: padding,
              decoration: const BoxDecoration(
                color: background_color,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: <Widget>[
                  CustomTextFormField(
                    validator: (value) {
                      if (value != null || value!.isEmpty) {
                        return null;
                      } else {
                        return 'This Field is Required';
                      }
                    },
                    controller: _cityController,
                    keyboardType: TextInputType.text,
                    hint: 'Enter City Name',
                  ),
                  SizedBox(height: padding.top), // Responsive spacing
                  CustomTextFormField(
                    validator: (value) {
                      if (value != null || value!.isEmpty) {
                        return null;
                      } else {
                        return 'This Field is Required';
                      }
                    },
                    controller: _streetController,
                    keyboardType: TextInputType.text,
                    hint: 'Enter Street Name',
                  ),
                  SizedBox(height: padding.top), // Responsive spacing
                  CustomTextFormField(
                    validator: (value) {
                      if (value != null || value!.isEmpty) {
                        return null;
                      } else {
                        return 'This Field is Required';
                      }
                    },
                    controller: _houseController,
                    keyboardType: TextInputType.text,
                    hint: 'Enter House Number',
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.03), // Responsive spacing
                  CustomButton(
                    title: 'Confirm Pickup',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
