import 'package:azlistview_plus/azlistview_plus.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entity/friend_entity.dart';
import 'contact_info_widget.dart';

class AlphContactList extends StatefulWidget {
  const AlphContactList({super.key,required this.friends});
  final List<FriendEntity>friends;


  @override
  State<AlphContactList> createState() => _AlphContactListState();

}

class _AlphContactListState extends State<AlphContactList> {
  @override
  void initState() {
    super.initState();
   SuspensionUtil.setShowSuspensionStatus(widget.friends);
  }
  @override
  Widget build(BuildContext context) {
    return AzListView(
      indexBarWidth: 0,
      indexBarHeight: 0,
      itemBuilder: (context, index) {

        final offStage=!widget.friends[index].isShowSuspension;
        return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Offstage(
            offstage: offStage,
            child: Padding(
              padding: const EdgeInsets.only(top: 30,left: 24,bottom: 5),
              child: Text(widget.friends[index].firstLetter,style:Theme.of(context).textTheme.titleLarge!.copyWith(color: AppTheme.black),),
            ),
          ),

          ContactInfoWidget( username:widget.friends[index].username, bio:widget.friends[index].bio,image:widget.friends[index].profilePic,isNeedToLeading: true,forFriend: true,),
        ],
      );
      },
      itemCount:widget.friends.length,
      data:widget.friends,




    );
  }
}
