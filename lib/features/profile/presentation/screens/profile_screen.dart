import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/core/widget/photo_open_screen.dart';
import 'package:chatbox/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chatbox/features/profile/presentation/cubit/profile_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/loading_indicator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenDim = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.black,
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const LoadingIndicator();
          } else if (state is ProfileSuccess) {
            final currentUser = state.message;
            // print(currentUser.address);

            return Column(
              children: [
                const SizedBox(height: 50),
                SizedBox(
                  // height: screenDim.height * 0.30,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppTheme.primary,
                                size: 30,
                              ),
                            ),
                            const Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PhotoOpenScreen(
                                          imageUrl: currentUser
                                              .profilePicture
                                              .secureUrl,
                                        ),
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: screenDim.height * 0.1,
                                    backgroundImage:
                                        currentUser
                                            .profilePicture
                                            .secureUrl
                                            .isNotEmpty
                                        ? NetworkImage(
                                            currentUser
                                                .profilePicture
                                                .secureUrl,
                                          )
                                        : null,
                                    child:
                                        currentUser
                                            .profilePicture
                                            .secureUrl
                                            .isEmpty
                                        ? Icon(
                                            Icons.person,
                                            size: screenDim.height * 0.2,
                                            color: Colors.grey,
                                          )
                                        : null,
                                  ),
                                ),

                                Text(
                                  currentUser.username,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),

                                const SizedBox(height: 2),
                                Text(
                                  currentUser.bio,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: AppTheme.gray),
                                ),
                              ],
                            ),
                            const Spacer(flex: 2),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: screenDim.height * 0.011),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: screenDim.width * 0.2,
                                  height: screenDim.height * 0.005,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 30),
                            _buildUserInfoItem(
                              context,
                              label: 'Display Name',
                              info: currentUser.username,
                              icon: Icons.person,
                            ),
                            const SizedBox(height: 20),

                            _buildUserInfoItem(
                              context,
                              label: 'Email Address',
                              info: currentUser.email,
                              icon: Icons.email_outlined,
                            ),
                            const SizedBox(height: 20),

                            _buildUserInfoItem(
                              context,
                              label: 'Address',
                              info: currentUser.address,
                              icon: Icons.location_on_outlined,
                            ),
                            const SizedBox(height: 20),

                            _buildUserInfoItem(
                              context,
                              label: 'Phone Number',
                              info: currentUser.phoneNumber,
                              icon: Icons.phone,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is ProfileFailure) {
            return Center(child: Text("Error: ${state.error}"));
          } else {
            return Center(child: Text("Error: $state"));
          }
        },
      ),
    );
  }

  Widget _buildUserInfoItem(
    BuildContext context, {
    required String label,
    required String info,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppTheme.darkGreen.withOpacity(0.1),
            child: Icon(
              icon ?? Icons.info_outline,
              color: AppTheme.darkGreen,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.gray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  info,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
