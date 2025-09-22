import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatbox/core/constants/friend_request_constant/handel_friend_constant.dart';
import 'package:chatbox/features/friend/presentation/cubit/friend_cubit/friend_cubit.dart';
import 'package:chatbox/features/friend/presentation/cubit/handel_friend_request_cubit/handel_friend_request_cubit.dart';
import 'package:chatbox/features/friend/presentation/cubit/handel_friend_request_cubit/handel_friend_request_states.dart';
import 'package:chatbox/features/friend/presentation/widgets/friend_request/request_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/app_snack_bars.dart';
import '../../../../../core/widget/loading_indicator.dart';
import '../../../data/model/handel_friend_request_model.dart';
import '../text_after_action.dart';


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
Expanded(
  flex: 2,
  child: BlocConsumer<HandelFriendRequestCubit, HandelFriendRequestStates>(
  listener: (context, state) {
    if(state is HandelFriendRequestError){
      AppSnackBars.showErrorSnackBar(context: context, message: state.error);
    }
    if (state is HandelFriendRequestSuccess){
      AppSnackBars.showSuccessSnackBar(context: context, message: state.message);
    }

  },
  builder: (context, state) {
    return state is HandelFriendRequestLoading ? const LoadingIndicator() :state is HandelFriendRequestSuccess?TextAfterAction(title:state.message,):state is HandelFriendRequestError ?const TextAfterAction(title:"Something went wrong please refresh your screen",):Row(
    children: [
      Expanded(child: RequestIcon(userName: username,onTap: (){
        context.read<HandelFriendRequestCubit>().handelFriendRequest(HandelFriendRequestModel(action:HandelFriendConstant.rejectFriend ,username:username));




      },iconPath:"rejectFriend" ,)),
      const SizedBox(width: 10,),
      Expanded(child: RequestIcon(userName: username,onTap: ()async{
        if (context.mounted) {
         await context.read<HandelFriendRequestCubit>()
              .handelFriendRequest(HandelFriendRequestModel(action:HandelFriendConstant.acceptFriend ,username:username));
          serviceLocator.get<FriendCubit>().fetchFriends();
        }

      },iconPath: "acceptFriend",)),


    ],

  );
  },
),
)





        ],
      ),
    );
  }
}
