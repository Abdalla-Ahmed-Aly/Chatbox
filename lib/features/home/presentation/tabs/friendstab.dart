import 'package:chatbox/features/home/presentation/widgets/contact_list.dart';
import 'package:chatbox/features/home/presentation/widgets/search_item.dart';
import 'package:flutter/material.dart' ;
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_theme.dart';
class FriendsTab extends StatelessWidget {
  const FriendsTab({super.key});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.sizeOf(context);
    return SafeArea(
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
            height: size.height * 0.04,
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
                      delegate: SearchItem(isFriendRequest: true)
                  );
                },
                child: SvgPicture.asset(
                  'assets/svg/addFriend.svg',
                  height: size.height * 0.04,
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
                topLeft: Radius.circular(size.width * 0.1),
                topRight: Radius.circular(size.width * 0.1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],

            ),
            child:ContactList(header: "My Friend",)

          ),
        )

      ],


      ),
    );
  }
}