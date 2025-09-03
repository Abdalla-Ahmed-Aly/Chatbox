import 'dart:io';

import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/core/widget/custom_button.dart';
import 'package:chatbox/core/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = '/updateProfile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String? recordedImagePath;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (picked != null) {
        setState(() {
          recordedImagePath = picked.path;
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Profile",
          style: textStyle.titleLarge?.copyWith(
            color: AppTheme.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  ClipOval(
                    child: recordedImagePath == null
                        ? Image.asset(
                            'assets/images/model1.png',
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                          )
                        : Image.file(
                            File(recordedImagePath!),
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.black, width: 2),
                        ),
                        child: Icon(
                          Icons.edit,
                          color: AppTheme.black,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            CustomTextFormField(
              textInputType: TextInputType.name,
              label: "User Name",
            ),
            const SizedBox(height: 20),

            CustomTextFormField(
              textInputType: TextInputType.phone,
              label: "Phone Number",
            ),
            const SizedBox(height: 20),

            CustomTextFormField(
              textInputType: TextInputType.streetAddress,
              label: "Address",
            ),
            const SizedBox(height: 30),

            CustomButton(
              onPressed: () {},
              text: "Update",
              buttonColor: AppTheme.lightGreen,
              textColor: AppTheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
