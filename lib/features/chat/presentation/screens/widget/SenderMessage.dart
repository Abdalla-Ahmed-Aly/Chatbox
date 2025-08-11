import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class SenderMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.5,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.lightGreen,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            'wdwddqqqqqqqqaSSSSSSSSSSSSSSSSSSSSSSSqqqqqqq',
            style: textTheme.bodyMedium!.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '09:25 AM',
          style: textTheme.bodySmall!.copyWith(
            color: AppTheme.gray,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
