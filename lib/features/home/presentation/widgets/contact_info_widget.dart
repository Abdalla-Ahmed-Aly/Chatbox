import 'package:chatbox/features/chat/presentation/screens/chatScreen.dart';
import 'package:chatbox/features/home/data/models/contact_model.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ContactInfoWidget extends StatelessWidget {
  const ContactInfoWidget({super.key,required this.contact});
final ContactModel contact;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme= Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Chatscreen.routeName),
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.015),
            margin:const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,

              ),
              child: ClipOval(
                  child: Image.asset(
                    contact.imagePath,
                    fit: BoxFit.cover,
                    width:60,
                    height:60
                  )
              )
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(contact.name,style: textTheme.titleLarge!.copyWith(color: AppTheme.black,fontSize: 18),),
              const SizedBox(height: 8,),
              Text(contact.bio,style: textTheme.bodySmall!.copyWith(color: AppTheme.gray,fontWeight: FontWeight.w500) ,)


            ],

          )


        ]
      ),
    );
}
}
