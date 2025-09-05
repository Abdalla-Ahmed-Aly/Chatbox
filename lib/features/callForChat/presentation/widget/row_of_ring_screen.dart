import 'package:chatbox/features/callForChat/presentation/widget/ring_icon.dart';
import 'package:chatbox/features/chat/presentation/screens/chatScreen.dart';
import 'package:flutter/cupertino.dart';

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
          onPress: () => Navigator.pushNamed(context, ChatScreen.routeName),
        ),
      ],
    );
  }
}
