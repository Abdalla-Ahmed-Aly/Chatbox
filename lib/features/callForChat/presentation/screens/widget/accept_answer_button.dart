import 'package:chatbox/features/callForChat/presentation/screens/call_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';

import '../../../../../core/theme/app_theme.dart';

class AcceptAnswerButton extends StatelessWidget {
  const AcceptAnswerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  SwipeButton(
      thumb: SvgPicture.asset("assets/svg/greenCall.svg",height: 18,width: 18,fit: BoxFit.scaleDown,),
      activeThumbColor:AppTheme.primary,
      activeTrackColor: AppTheme.primary.withValues(alpha: .3),
      thumbPadding: const EdgeInsets.all(6),
      borderRadius: BorderRadius.circular(30),
      width: MediaQuery.sizeOf(context).width*.69,
      onSwipe: () {
Navigator.pushReplacementNamed(context, CallScreen.routeName);
      },
      child: Text(
        "slide to answer",
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w500)
      ),
    );
  }
}
