import 'package:chatbox/core/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_theme.dart';
import 'loading_indicator.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key,required this.actionButtonText,required this.title,required this.description,required this.onActionPressed, this.isLoading=false});
  final String title;
  final String description;
  final String actionButtonText;
  final VoidCallback onActionPressed;
  final bool isLoading;


  @override
  Widget build(BuildContext context) {
    TextTheme textStyle=Theme.of(context).textTheme;
    return AlertDialog(
      title: Text(title,style: textStyle.headlineSmall!.copyWith(color: AppTheme.black,fontWeight: FontWeight.w500),),
      content:isLoading?null:Text(description,style: textStyle.headlineMedium!.copyWith(color: AppTheme.black),),
      actions:isLoading?[
        LoadingIndicator()

      ]:[
        CustomButton(onPressed: onActionPressed ,text: actionButtonText,buttonColor: AppTheme.red,),
        const SizedBox(height: 20,),
        CustomButton(onPressed: (){
          context.pop();
        }, text: "Cancel",buttonColor: AppTheme.gray,),
      ],



    );
  }
}
