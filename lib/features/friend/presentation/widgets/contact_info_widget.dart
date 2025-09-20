import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatbox/core/route/route_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class ContactInfoWidget extends StatelessWidget {
  const ContactInfoWidget({
    super.key,
    this.isNeedToLeadingIcon = false,
    this.verticalPadding = 0,
    required this.username,
    required this.bio,
    required this.image
  });

  final bool isNeedToLeadingIcon;
  final double verticalPadding;
  final String username;
  final String bio;
  final String image;


  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => isNeedToLeadingIcon
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
              isNeedToLeadingIcon
                  ? GestureDetector(
                      onTap: () => context.push(RouteCenter.qrCode),
                      child: SvgPicture.asset(
                        "assets/svg/qrCode.svg",
                        width:30,
                        height: 30,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
