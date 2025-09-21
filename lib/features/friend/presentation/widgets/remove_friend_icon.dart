import 'package:chatbox/core/model/shared_request.dart';
import 'package:chatbox/core/widget/custom_alert_dialog.dart';
import 'package:chatbox/features/friend/presentation/cubit/remove_friend_cubit/remove_friend_cubit.dart';
import 'package:chatbox/features/friend/presentation/cubit/remove_friend_cubit/remove_friend_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/app_snack_bars.dart';
import '../cubit/friend_cubit/friend_cubit.dart';

class RemoveFriendIcon extends StatelessWidget {
  const RemoveFriendIcon({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 20),
        child: GestureDetector(
            onTap: () {
              showDialog(context: context, builder: (context) => MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => serviceLocator.get<RemoveFriendCubit>(),
    ),

  ],
  child: BlocConsumer<RemoveFriendCubit, RemoveFriendStates>(
    listener: (context, state) {
      if (state is RemoveFriendError) {
        AppSnackBars.showErrorSnackBar(
            context: context, message: state.error);
      }
      else if (state is RemoveFriendSuccess) {
        AppSnackBars.showSuccessSnackBar(
            context: context, message: state.message);
      }
    },
  builder: (context, state) {
    return  CustomAlertDialog(actionButtonText: "Remove", title: "Remove Friend", description: "Are you sure",isLoading:state is RemoveFriendLoading , onActionPressed: ()async{
     await context.read<RemoveFriendCubit>().removeFriend(SharedRequest(username: userName));
     if (!context.mounted) return;
      context.read<FriendCubit>().fetchFriends();
      context.pop();

    },);
  },
),
),
                  );
            },
            child: SvgPicture.asset(
              "assets/svg/removeFriend.svg",
              width: 26,
              height: 26,
            )

        )

    );
  }
}
