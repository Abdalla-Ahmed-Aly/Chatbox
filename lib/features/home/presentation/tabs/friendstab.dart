import 'package:chatbox/core/widget/error_indicator.dart';
import 'package:chatbox/core/widget/loading_indicator.dart';
import 'package:chatbox/features/friend/presentation/cubit/friend_cubit/friend_cubit.dart';
import 'package:chatbox/features/friend/presentation/cubit/friend_cubit/friend_stats.dart';
import 'package:flutter/material.dart' ;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../friend/presentation/widgets/contact_list.dart';
import '../../../friend/presentation/widgets/friend_request_button.dart';
import '../../../friend/presentation/widgets/friend_search_item.dart';
import '../../../friend/presentation/widgets/search_item.dart';
class FriendsTab extends StatelessWidget {
  const FriendsTab({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppTheme.black,
      floatingActionButton:const FriendRequestButton(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () async{
                      await showSearch(
                          context: context,
                          delegate: SearchItem()
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/svg/Group 370.svg',
                      height: 44,
                      width: 44,
                    ),
                  ),
                  Text(
                    'Friends',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () async{
                      await showSearch(
                          context: context,
                          delegate: FriendSearchItem()
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/svg/addFriend.svg',
                      height: 44,
                      width: 44,
                    ),
                  ),


                ],
              ),
            ),
            const SizedBox(height: 30,),
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
                  child:BlocBuilder<FriendCubit, FriendStats>(
  builder: (context, state) {
    if(state is FriendStatsLoading){
      return const LoadingIndicator();
    }else if(state is FriendStatsError){
      return ErrorIndicator(error: state.message);
    }else if(state is FriendStatsSuccess ) {

      return ContactList(header: "My Friend", friends: state.friends,);

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