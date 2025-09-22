import 'dart:io';

import 'package:chatbox/core/di/service_locator.dart';
import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/core/utils/app_snack_bars.dart';
import 'package:chatbox/core/utils/validator.dart';
import 'package:chatbox/core/widget/custom_button.dart';
import 'package:chatbox/core/widget/custom_text_form_field.dart';
import 'package:chatbox/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chatbox/features/profile/presentation/cubit/profile_state.dart';
import 'package:chatbox/features/profile/presentation/screens/custom_image_crop.dart';
import 'package:chatbox/features/updateProfile/data/model/photoRequest.dart';
import 'package:chatbox/features/updateProfile/data/model/update_profile_request.dart';
import 'package:chatbox/features/updateProfile/presentation/cubit/updateProfile_cubit.dart';
import 'package:chatbox/features/updateProfile/presentation/cubit/updateProfile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
  File? _profileImage;

  Future<void> pickImageFromGallery(
    BuildContext context,
    UpdateprofileCubit updateProfileCubit,
  ) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 80,
    );
    if (image != null) {
      localImagePath = image.path;
      _navigateToCropScreen(context, File(localImagePath!), updateProfileCubit);
    }
  }

  Future<void> pickImageFromCamera(
    BuildContext context,
    UpdateprofileCubit updateProfileCubit,
  ) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 80,
    );
    if (image != null) {
      localImagePath = image.path;
      _navigateToCropScreen(context, File(localImagePath!), updateProfileCubit);
    }
  }

  Future<void> _navigateToCropScreen(
    BuildContext context,
    File imageFile,
    UpdateprofileCubit updateProfileCubit,
  ) async {
    final result = await Navigator.push<File?>(
      context,
      MaterialPageRoute(
        builder: (context) => CustomImageCropScreen(
          cameraImage: imageFile,
          onCropped: (croppedFile) {
            if (croppedFile != null) {
              print('Image cropped successfully: ${croppedFile.path}');
            }
          },
        ),
      ),
    );

    if (result != null) {
      Navigator.pop(context);
      setState(() {
        localImagePath = result.path;
      });

      if (localImagePath != null) {
        await updateProfileCubit.updateProfilePhoto(
          PhotoRequest(image: File(localImagePath!)),
        );

        if (mounted) {
          serviceLocator.get<ProfileCubit>().getUserProfile();
        }
      }
    }
  }

  Future<void> showPickingOptions(
    double height,
    BuildContext context,
    UpdateprofileCubit updateProfileCubit,
  ) async {
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          color: AppTheme.primary,
        ),
        height: height * 0.35,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildControlButton(
                  onTap: () => Navigator.pop(context),
                  icon: Icons.close,
                ),
                Text(
                  'Profile Photo',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildControlButton(
                  onTap: () {}, //_removeProfileImage,
                  icon: Icons.delete_outline_rounded,
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildPickingOptions(
              onTap: () => pickImageFromCamera(context, updateProfileCubit),
              context,
              icon: Icons.camera_alt_outlined,
              label: 'Camera',
            ),
            _buildPickingOptions(
              onTap: () => pickImageFromGallery(context, updateProfileCubit),
              context,
              icon: Icons.image,
              label: 'Gallery',
            ),
            _buildPickingOptions(
              onTap: () {
                Navigator.pop(context);
              },
              context,
              icon: Icons.emoji_emotions,
              label: 'Avatar',
            ),
          ],
        ),
      ),
    );
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
    Size screendim = MediaQuery.sizeOf(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppTheme.black),
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
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            AppSnackBars.showErrorSnackBar(
                              context: context,
                              message: state.error.toString(),
                            );
                          });
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () async {
                          final cubit = context.read<UpdateprofileCubit>();
                          showPickingOptions(screendim.height, context, cubit);
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                        await  context.read<UpdateprofileCubit>().updateProfile(
                            UpdateProfileRequest(
                              address: addressController.text,
                              bio: biController.text,
                              phoneNumber: phoneController.text,
                              username: nameController.text,
                            ),
                          );

                          serviceLocator.get<ProfileCubit>().getUserProfile();
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

  Widget _buildPickingOptions(
    BuildContext context, {
    required VoidCallback onTap,
    required String label,
    required IconData icon,
  }) {
    return Material(
      color: Colors.transparent,
      shape: const BeveledRectangleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const BeveledRectangleBorder(),
        splashColor: AppTheme.darkGreen.withOpacity(0.5),
        highlightColor: AppTheme.darkGreen.withOpacity(0.5),
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Icon(icon, size: 30, color: AppTheme.darkGreen),
              const SizedBox(width: 10),
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: AppTheme.darkGreen),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton({
    String? svgPath,
    IconData? icon = Icons.hourglass_empty,
    required VoidCallback onTap,
    double height = 30,
    double width = 30,
  }) {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppTheme.darkGreen,
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: svgPath != null
                ? SvgPicture.asset(svgPath, height: height, width: width)
                : Icon(icon, size: 30, color: AppTheme.primary),
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
