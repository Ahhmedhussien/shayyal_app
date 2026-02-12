import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shyal/Component/Icon_BackGrounded.dart';
import 'package:shyal/Models/ProfileModel.dart';
import 'package:shyal/Services/ProfileService.dart';
import 'package:shyal/const.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  late Future<ProfileModel> futureProfile;

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile();
  }

  Future<ProfileModel> fetchProfile() async {
    final profileService = ProfileService();

    try {
      return await profileService.fetchProfile();
    } catch (e) {
      print('Error: $e');
      throw e; // Rethrow the error to handle it in FutureBuilder
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    var iconContainerSize = screenSize.width * 0.12;

    var edgePadding = screenSize.width * 0.02;

    var locationFontSize = screenSize.width * 0.03;
    var cityFontSize = screenSize.width * 0.04;

    return Padding(
      padding: EdgeInsets.all(edgePadding),
      child: FutureBuilder<ProfileModel>(
        future: futureProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No profile data found'));
          } else {
            ProfileModel profile = snapshot.data!;

            Widget imageWidget = profile.profileImage != null
                ? Image.memory(
                    Uint8List.fromList(profile.profileImage!),
                    width: iconContainerSize,
                    height: iconContainerSize,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/img/AlanWalker.jpg', // Specify your default image path
                    width: iconContainerSize,
                    height: iconContainerSize,
                    fit: BoxFit.cover,
                  );

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Icon_BackGrounded(
                      color: Secound_background_color,
                      iconContainerSize: iconContainerSize,
                      icon: const Icon(
                        Icons.location_on,
                        color: Secound_green_color,
                      ),
                    ),
                    SizedBox(width: edgePadding),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Hi,',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: locationFontSize * 1.5,
                          ),
                        ),
                        Text(
                          '${profile.firstName} ${profile.lastName}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: cityFontSize,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: imageWidget),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
