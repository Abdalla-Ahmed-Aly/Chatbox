import 'package:flutter/cupertino.dart';

import '../theme/app_theme.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({super.key,required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error,style: TextStyle(color: AppTheme.black),),


    );
  }
}
