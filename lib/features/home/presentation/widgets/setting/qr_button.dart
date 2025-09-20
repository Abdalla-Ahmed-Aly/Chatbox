import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/route/route_center.dart';

class QrButton extends StatelessWidget {
  const QrButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => context.push(RouteCenter.qrCode),
      child: SvgPicture.asset(
        "assets/svg/qrCode.svg",
        width:30,
        height: 30,
      ),
    );
  }
}
