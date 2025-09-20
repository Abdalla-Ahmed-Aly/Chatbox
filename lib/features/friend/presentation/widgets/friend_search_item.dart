import 'package:chatbox/core/theme/search_delegate_theme.dart';
import 'package:chatbox/core/utils/app_snack_bars.dart';
import 'package:chatbox/features/friend/presentation/cubit/add_friend_cubit/add_friend_cubit.dart';
import 'package:chatbox/features/friend/presentation/cubit/add_friend_cubit/add_friend_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/model/shared_request.dart';
import 'app_bar_icon.dart';


class FriendSearchItem extends SearchDelegate {

  FriendSearchItem();

  @override
  String get searchFieldLabel => "Add friend with his username";

  @override
  ThemeData appBarTheme(BuildContext context) {
    return SearchDelegateTheme.searchTheme;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      BlocProvider(
        create: (context) => serviceLocator.get<AddFriendCubit>(),
        child: BlocConsumer<AddFriendCubit, AddFriendStates>(
          listener: (context, state) {
            if (state is AddFriendError) {
              AppSnackBars.showErrorSnackBar(
                  context: context, message: state.error);
            }
            else if (state is AddFriendSuccess) {
              AppSnackBars.showSuccessSnackBar(
                  context: context, message: state.message);
              close(context, null);


            }
          },
          builder: (context, state) {
            return AbsorbPointer(
              absorbing: state is AddFriendLoading,
              child: AppBarIcon(onPressed: () {
                context.read<AddFriendCubit>().addFriend(
                    SharedRequest(username: query));

              }
                , icon:state is AddFriendLoading?CupertinoIcons.circle : CupertinoIcons.search),
            );
          },
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return AppBarIcon(onPressed: () {
      close(context, null);
    }, icon: CupertinoIcons.back,);
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold(


    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold();
  }


}