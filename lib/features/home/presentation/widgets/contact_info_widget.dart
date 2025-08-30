import 'package:chatbox/features/chat/presentation/screens/chatScreen.dart';
import 'package:chatbox/features/home/data/models/contact_model.dart';

import 'package:chatbox/features/home/presentation/widgets/qr_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_theme.dart';

class ContactInfoWidget extends StatelessWidget {
  const ContactInfoWidget({super.key,required this.contact,this.isNeedToLeadingIcon=false});
final ContactModel contact;
final bool isNeedToLeadingIcon;


  @override
  Widget build(BuildContext context) {
    TextTheme textTheme= Theme.of(context).textTheme;
    Size screenSize=MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () =>isNeedToLeadingIcon?null:Navigator.pushNamed(context, ChatScreen.routeName),
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
              const SizedBox(
                height: 15,
              ),
              Text(contact.name,style: textTheme.titleLarge!.copyWith(color: AppTheme.black,fontSize: 18),),
              const SizedBox(height: 4,),
              Text(contact.bio,style: textTheme.bodySmall!.copyWith(color: AppTheme.gray,fontWeight: FontWeight.w500) ,)


            ],

          ),
          Spacer(),
          isNeedToLeadingIcon?GestureDetector(onTap: () =>Navigator.pushNamed(context, QrCodeScreen.routeName),
              child: SvgPicture.asset("assets/svg/qrCode.svg",width: screenSize.width*0.027,height: screenSize.height*0.027,)):const SizedBox(),



        ]
      ),
    );
}
}
