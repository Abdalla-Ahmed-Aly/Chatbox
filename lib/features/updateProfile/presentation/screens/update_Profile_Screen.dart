import 'dart:io';

import 'package:chatbox/core/di/service_locator.dart';
import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/core/utils/app_snack_bars.dart';
import 'package:chatbox/core/utils/validator.dart';
import 'package:chatbox/core/widget/custom_button.dart';
import 'package:chatbox/core/widget/custom_text_form_field.dart';
import 'package:chatbox/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chatbox/features/profile/presentation/cubit/profile_state.dart';
import 'package:chatbox/features/updateProfile/data/model/photoRequest.dart';
import 'package:chatbox/features/updateProfile/data/model/update_profile_request.dart';
import 'package:chatbox/features/updateProfile/presentation/cubit/updateProfile_cubit.dart';
import 'package:chatbox/features/updateProfile/presentation/cubit/updateProfile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController biController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? localImagePath;
  String? serverImageUrl;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (picked != null) {
        setState(() {
          localImagePath = picked.path;
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    final profileCubit = serviceLocator<ProfileCubit>();
    final state = profileCubit.state;

    if (state is ProfileSuccess) {
      serverImageUrl = state.message.profilePicture.secureUrl;
      nameController.text = state.message.username;
      phoneController.text = state.message.phoneNumber;
      addressController.text = state.message.address;
      biController.text = state.message.bio;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return Form(
      key: _formKey,
      child: Scaffold(
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
                  alignment: Alignment.center,
                  children: [
                    ClipOval(
                      child: localImagePath != null
                          ? Image.file(
                              File(localImagePath!),
                              fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                            )
                          : (serverImageUrl != null
                                ? Image.network(
                                    serverImageUrl!,
                                    fit: BoxFit.cover,
                                    width: 120,
                                    height: 120,
                                  )
                                : Image.asset(
                                    'assets/images/model1.png',
                                    fit: BoxFit.cover,
                                    width: 120,
                                    height: 120,
                                  )),
                    ),

                    BlocBuilder<UpdateprofileCubit, UpdateprofileState>(
                      builder: (context, state) {
                        if (state is UpdateprofilePhotoLoading) {
                          return Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                          );
                        } else if (state is UpdateprofilePhotoFailure) {
                          AppSnackBars.showErrorSnackBar(
                            context: context,
                            message: state.error.toString(),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () async {
                          await pickImage();

                          if (localImagePath != null) {
                            final cubit = context.read<UpdateprofileCubit>();
                            await cubit.updateProfilePhoto(
                              PhotoRequest(image: File(localImagePath!)),
                            );

                            if (mounted) {
                              serviceLocator.get<ProfileCubit>()
                                ..getUserProfile();
                            }
                          }
                        },
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
                controller: nameController,
                validator: (value) => Validator.validateField(value, 'name'),
              ),
              const SizedBox(height: 20),

              CustomTextFormField(
                textInputType: TextInputType.phone,
                label: "Phone Number",
                controller: phoneController,
                validator: (value) => Validator.validateField(value, 'phone'),
              ),
              const SizedBox(height: 20),

              CustomTextFormField(
                textInputType: TextInputType.streetAddress,
                label: "Address",
                controller: addressController,
                validator: (value) => Validator.validateField(value, 'address'),
              ),
              const SizedBox(height: 20),

              CustomTextFormField(
                textInputType: TextInputType.streetAddress,
                label: "Bio",
                controller: biController,
                validator: (value) => Validator.validateField(value, 'bio'),
              ),
              const SizedBox(height: 30),

              BlocConsumer<UpdateprofileCubit, UpdateprofileState>(
                listener: (context, state) {
                  if (state is UpdateprofileSuccess) {
                    AppSnackBars.showSuccessSnackBar(
                      context: context,
                      message: state.update.message,
                    );
                  } else if (state is UpdateprofileFailure) {
                    AppSnackBars.showErrorSnackBar(
                      context: context,
                      message: state.error.toString(),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UpdateprofileLoading) {}
                  return AbsorbPointer(
                    absorbing: state is UpdateprofileLoading,
                    child: CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<UpdateprofileCubit>().updateProfile(
                            UpdateProfileRequest(
                              address: addressController.text,
                              bio: biController.text,
                              phoneNumber: phoneController.text,
                              username: nameController.text,
                            ),
                          );

                          serviceLocator.get<ProfileCubit>()..getUserProfile();
                        }
                      },
                      isLoading: state is UpdateprofileLoading,
                      text: "Update Profile",
                      buttonColor: AppTheme.lightGreen,
                      textColor: AppTheme.primary,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    biController.dispose();

    super.dispose();
  }
}
