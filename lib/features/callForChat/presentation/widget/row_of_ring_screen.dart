import 'package:chatbox/core/route/route_center.dart';
import 'package:chatbox/features/callForChat/presentation/widget/ring_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class RowOfRingScreen extends StatelessWidget {
  const RowOfRingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RingIcon(title: "Remind me", iconPath: "alarm", onPress: () {}),
        RingIcon(
          title: "Message",
          iconPath: "message",
          onPress: () => context.push(RouteCenter.chatScreen),
        ),
      ],
    );
  }
}
