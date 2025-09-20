import 'package:chatbox/features/friend/domain/entity/friend_entity.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'alph_contact_list.dart';
import 'not_alph_contact_list.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key,required this.header,this.isAlph=true,required this.friends});
final String header;
final bool isAlph;
final List<FriendEntity>friends;
  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start
    ,children: [
      Padding(
        padding: const EdgeInsets.only(left: 24,right: 24,top: 30),
        child: Text(header,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppTheme.black),),
      ),
    Expanded(
      child:isAlph? AlphContactList(friends: friends,):NotAlphContactList()
    )

    ],);
  }
}
