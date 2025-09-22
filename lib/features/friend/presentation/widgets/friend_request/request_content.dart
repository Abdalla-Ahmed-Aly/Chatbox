import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatbox/features/friend/presentation/widgets/friend_request/request_icon.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';


class RequestContent extends StatelessWidget {
  const RequestContent({
    super.key,
    required this.username,
    required this.bio,
    required this.image,

  });
  final String username;
  final String bio;
  final String image;



  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
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
          RequestIcon(userName: username,onTap: (){},iconPath:"rejectFriend" ,),
          const SizedBox(width: 10,),
          RequestIcon(userName: username,onTap: (){},iconPath: "acceptFriend",),




        ],
      ),
    );
  }
}
