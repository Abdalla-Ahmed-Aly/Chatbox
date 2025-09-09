import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.isButton = false});
final bool isButton;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color:isButton?AppTheme.primary:AppTheme.green,
      ),
    );
  }
}
