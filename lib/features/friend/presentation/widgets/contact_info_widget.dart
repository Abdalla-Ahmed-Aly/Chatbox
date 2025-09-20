import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatbox/core/route/route_center.dart';
import 'package:chatbox/features/friend/presentation/widgets/remove_friend_icon.dart';
import 'package:chatbox/features/home/presentation/widgets/setting/qr_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class ContactInfoWidget extends StatelessWidget {
  const ContactInfoWidget({
    super.key,
    this.isNeedToLeading = false,
    this.verticalPadding = 0,
    required this.username,
    required this.bio,
    required this.image,
    this.forFriend=false
  });

  final bool isNeedToLeading;
  final double verticalPadding;
  final String username;
  final String bio;
  final String image;
  final bool forFriend;


  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => isNeedToLeading
            ? context.push(RouteCenter.profileScreen)
            : context.push(RouteCenter.chatScreen),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height * 0.015,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(shape: BoxShape.circle),
                child:
                ClipRRect(
                  borderRadius: BorderRadius.circular(31),
                  child: Container(
                    height: 52,
                    width: 52,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const SizedBox(height: 15),
                  Text(
                    username,
                    style: textTheme.titleLarge!.copyWith(
                      color: AppTheme.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bio,
                    style: textTheme.bodySmall!.copyWith(
                      color: AppTheme.gray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Spacer(),
              isNeedToLeading
                  ?forFriend? RemoveFriendIcon(userName: username):const QrButton()
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
