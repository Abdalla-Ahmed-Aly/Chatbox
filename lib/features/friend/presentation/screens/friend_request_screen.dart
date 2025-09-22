import 'package:chatbox/features/friend/presentation/widgets/friend_request/request_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widget/error_indicator.dart';
import '../../../../core/widget/loading_indicator.dart';
import '../cubit/friend_request_cubit/friend_request_cubit.dart';
import '../cubit/friend_request_cubit/friend_request_states.dart';

class FriendRequestScreen extends StatefulWidget {
  const FriendRequestScreen({super.key});

  @override
  State<FriendRequestScreen> createState() => _FriendRequestScreenState();
}

class _FriendRequestScreenState extends State<FriendRequestScreen> {
  @override
  void initState() {
context.read<FriendRequestCubit>().fetchFriendRequest();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black,
      appBar: AppBar(title: Text("Friends Request"),),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15,),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 10,
                        offset: Offset(0, -2),
                      ),
                    ],

                  ),
                  child: BlocBuilder<FriendRequestCubit, FriendRequestStates>(
                    builder: (context, state) {
                      if (state is FriendRequestSuccess){
                      return RequestList(friendRequestList: state.friends,);
                      }else if(state is FriendRequestError){
                        return ErrorIndicator(error: state.error);
                      }
                      else if(state is FriendRequestLoading){
                        return const LoadingIndicator();
                      }else{
                        return const SizedBox();
                      }
                    },
                  )

              ),
            )

          ],


        ),
      ),


    );
  }
}
