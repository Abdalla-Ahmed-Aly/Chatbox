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
    this.forFriend = false,
    this.isMe=false,
  });

  final bool isNeedToLeading;
  final double verticalPadding;
  final String username;
  final String bio;
  final String image;
  final bool forFriend;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => isMe
            ? context.push(RouteCenter.profileScreen)
            : context.push(RouteCenter.profileScreenUser,extra: username),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(31),
                  child: Container(
                    height: 52,
                    width: 52,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image.network(image, fit: BoxFit.fill),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
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
              ),
              Spacer(),
              isNeedToLeading
                  ? forFriend
                        ?  Expanded(child: RemoveFriendIcon(userName: username,))
                        : Expanded(child: const QrButton())
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
