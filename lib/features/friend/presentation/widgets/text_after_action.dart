import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class TextAfterAction extends StatelessWidget {
  const TextAfterAction({super.key,required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.black),);
  }
}
