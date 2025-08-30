import 'package:chatbox/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key,required this.label,required this.onTap});
final String label;
final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: onTap,
    child: Text(label,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppTheme.lightGreen)));
  }
}