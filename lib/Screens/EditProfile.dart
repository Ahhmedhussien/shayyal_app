import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/LogServes.dart';
import 'package:shyal/Models/ProfileModel.dart';
import 'package:shyal/Services/ProfileService.dart';
import 'package:shyal/const.dart';
import 'package:shyal/Component/CustomTextFormField.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late Future<ProfileModel> futureProfile;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    futureProfile.then((profile) {
      setState(() {
        firstNameController.text = profile.firstName;
        lastNameController.text = profile.lastName;
        phoneController.text = profile.phone;
      });
    }).catchError((error) {
      // Handle potential errors
      LogService.error('Failed to load profile: $error');
    });
    ;
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
      futureProfile = fetchProfile();
    });
  }

  void _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      // Assuming your profile model is correctly set up
      EditProfileModel updatedProfile = EditProfileModel(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phone: phoneController.text,
      );

      bool success = await ProfileService().updateProfile(updatedProfile);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
        Navigator.pop(context); // Optionally pop back if update is successful
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: background_color,
        centerTitle: true,
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<ProfileModel>(
        future: futureProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return buildProfileForm(snapshot.data!, screenSize);
          } else {
            return const Text('No profile data found');
          }
        },
      ),
    );
  }

  Widget buildProfileForm(ProfileModel profile, Size screenSize) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          profile.profileImage != null
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
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.cyan),
                            onPressed: () {
                              setState(() {
                                pickImageAndUpdate();
                              });
                              print("Edit icon pressed");
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.03),
                    TextFormField(
                      controller: firstNameController,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.04),
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
                        filled: true,
                        fillColor: Secound_background_color,
                        hintText: "First Name",
                        hintStyle: const TextStyle(color: Colors.white54),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.03),
                    TextFormField(
                      controller: lastNameController,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.04),
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
                        filled: true,
                        fillColor: Secound_background_color,
                        hintText: "Last Name",
                        hintStyle: const TextStyle(color: Colors.white54),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.03),
                    TextFormField(
                      controller: phoneController,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.04),
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
                        filled: true,
                        fillColor: Secound_background_color,
                        hintText: "Phone",
                        hintStyle: const TextStyle(color: Colors.white54),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.03),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(title: 'save', onPressed: _updateProfile),
          )
        ],
      ),
    );
  }
}
