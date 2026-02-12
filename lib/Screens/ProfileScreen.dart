// import 'package:flutter/material.dart';
// import 'package:shyal/Component/CustomButton.dart';
// import 'package:shyal/Component/CustomProfileButton.dart';
// import 'package:shyal/Models/ProfileModel.dart';
// import 'package:shyal/Services/ProfileService.dart';
// import 'package:shyal/Widgets/BattomNavigationBar.dart';
// import 'package:shyal/const.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {

//   late Future<ProfileModel> futureProfile;

//   @override
//   void initState() {
//     super.initState();
//     futureProfile = fetchProfile();
//   }

//   Future<ProfileModel> fetchProfile() async {
//     final profileService = ProfileService();

//     try {
//       return await profileService.fetchProfile();
//     } catch (e) {
//       print('Error: $e');
//       throw e; // Rethrow the error to handle it in FutureBuilder
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;

//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(screenSize.width * 0.05),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Align(
//                 alignment: Alignment.center,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Profile',
//                       style: TextStyle(fontSize: screenSize.width * 0.05),
//                     ),
//                     SizedBox(height: screenSize.height * 0.02),
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(16),
//                       child: Image.asset(
//                         'assets/img/AlanWalker.jpg',
//                         width: screenSize.width * 0.25,
//                         height: screenSize.height * 0.12,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     SizedBox(height: screenSize.height * 0.02),
//                     Text(
//                       'Steven Bahaa',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: screenSize.width * 0.065),
//                     ),
//                     SizedBox(height: screenSize.height * 0.01),
//                     Text(
//                       'StevenBahaa08@gmail.com',
//                       style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: screenSize.width * 0.04),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       CustomProfileButton(
//                         screenSize: screenSize,
//                         onTap: () {
//                           Navigator.pushReplacementNamed(
//                               context, '/EditProfile');
//                         },
//                         leftIcon: Icons.edit,
//                         rightIcon: Icons.chevron_right,
//                         title: 'Edit Profile',
//                       ),
//                       SizedBox(
//                         height: screenSize.height * 0.02,
//                       ),
//                       CustomProfileButton(
//                         screenSize: screenSize,
//                         onTap: () {
//                           Navigator.pushReplacementNamed(
//                               context, '/MyAddressScreen');
//                         },
//                         leftIcon: Icons.edit,
//                         rightIcon: Icons.chevron_right,
//                         title: 'My Address',
//                       ),
//                       SizedBox(
//                         height: screenSize.height * 0.02,
//                       ),
//                       CustomProfileButton(
//                         screenSize: screenSize,
//                         onTap: () {
//                           Navigator.pushReplacementNamed(
//                               context, '/OrderHistoryScreen');
//                         },
//                         leftIcon: Icons.edit,
//                         rightIcon: Icons.chevron_right,
//                         title: 'My Orders',
//                       ),
//                       SizedBox(
//                         height: screenSize.height * 0.02,
//                       ),
//                       CustomProfileButton(
//                         screenSize: screenSize,
//                         onTap: () {
//                           Navigator.pushReplacementNamed(
//                               context, '/NewPasswordScreen');
//                         },
//                         leftIcon: Icons.edit,
//                         rightIcon: Icons.chevron_right,
//                         title: 'Change Password',
//                       ),
//                       SizedBox(
//                         height: screenSize.height * 0.02,
//                       ),
//                       SizedBox(
//                         height: screenSize.height * 0.02,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               CustomButton(
//                   title: 'Logout',
//                   onPressed: () {
//                     Navigator.pushReplacementNamed(context, '/LoginScreen');
//                   }),
//               SizedBox(
//                 height: screenSize.height * 0.02,
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: const BottomBar(),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushReplacementNamed(context, '/SendPackageScreen');
//         },
//         backgroundColor: Secound_green_color,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/Component/CustomProfileButton.dart';
import 'package:shyal/Models/ProfileModel.dart';
import 'package:shyal/Screens/EditProfile.dart';
import 'package:shyal/Services/ProfileService.dart';
import 'package:shyal/Widgets/BattomNavigationBar.dart';
import 'package:shyal/const.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<ProfileModel> futureProfile;
  final ImagePicker _picker = ImagePicker();

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

  Future<void> pickImageAndUpdate() async {
    final profileService = ProfileService();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File imageFile = File(image.path);
      await profileService.updateAdminProfile(profileImage: imageFile);
    }
    setState(() {
      futureProfile = fetchProfile(); // Re-fetch or update the profile data
    });
  }
  

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: FutureBuilder<ProfileModel>(
                  future: futureProfile,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      ProfileModel profile = snapshot.data!;
                      return Column(
                        children: [
                          Text(
                            'Profile',
                            style: TextStyle(fontSize: screenSize.width * 0.05),
                          ),
                          SizedBox(height: screenSize.height * 0.02),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: profile.profileImage != null
                                ? Image.memory(
                                    Uint8List.fromList(profile.profileImage!),
                                    width: screenSize.width * 0.25,
                                    height: screenSize.height * 0.12,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/img/AlanWalker.jpg',
                                    width: screenSize.width * 0.25,
                                    height: screenSize.height * 0.12,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          SizedBox(height: screenSize.height * 0.02),
                          Text(
                            '${profile.firstName} ${profile.lastName}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: screenSize.width * 0.065),
                          ),
                          SizedBox(height: screenSize.height * 0.01),
                          Text(
                            profile.email,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: screenSize.width * 0.04),
                          ),
                        ],
                      );
                    } else {
                      return Text("No data found");
                    }
                  },
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomProfileButton(
                        screenSize: screenSize,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfile(),
                            ),
                          );
                        },
                        leftIcon: Icons.edit,
                        rightIcon: Icons.chevron_right,
                        title: 'Edit Profile',
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      CustomProfileButton(
                        screenSize: screenSize,
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, '/MyAddressScreen');
                        },
                        leftIcon: Icons.edit,
                        rightIcon: Icons.chevron_right,
                        title: 'My Address',
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      CustomProfileButton(
                        screenSize: screenSize,
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, '/OrderHistoryScreen');
                        },
                        leftIcon: Icons.edit,
                        rightIcon: Icons.chevron_right,
                        title: 'My Orders',
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      CustomProfileButton(
                        screenSize: screenSize,
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, '/NewPasswordScreen');
                        },
                        leftIcon: Icons.edit,
                        rightIcon: Icons.chevron_right,
                        title: 'Change Password',
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                  title: 'Logout',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/LoginScreen');
                  }),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
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
