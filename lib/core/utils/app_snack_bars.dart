import 'package:flutter/material.dart';

import '../theme/app_theme.dart';


abstract class AppSnackBars {
  static void showSuccessSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: AppTheme.darkWhite),
        ),
        backgroundColor: AppTheme.green,
      ),
    );
  }

  static void showErrorSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: AppTheme.darkWhite),
        ),
        backgroundColor: AppTheme.red,
      ),
    );
  }
}