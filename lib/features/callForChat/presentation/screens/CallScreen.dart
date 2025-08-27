import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/features/callForChat/presentation/screens/widget/custom_button_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Callscreen extends StatefulWidget {
  static const String routeName = '/Callscreen';

  @override
  State<Callscreen> createState() => _CallscreenState();
}

class _CallscreenState extends State<Callscreen> {
  bool isMicOn = true;
  bool isSpeakerOn = true;
  bool isVideoOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/photoChat.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 50, right: 15),
              child: Image.asset(
                'assets/images/photoChat2.png',
                height: 150,
                width: 100,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonChat(
                    icon: isMicOn
                        ? Icons.mic_none_outlined
                        : Icons.mic_off_outlined,
                    color: Colors.white38,
                    onPressed: () {
                      isMicOn = !isMicOn;
                      setState(() {});
                    },
                  ),
                  const SizedBox(width: 20),
                  CustomButtonChat(
                    icon: isSpeakerOn
                        ? Icons.volume_up_rounded
                        : Icons.volume_off_rounded,
                    color: Colors.white38,
                    onPressed: () {
                      isSpeakerOn = !isSpeakerOn;
                      setState(() {});
                    },
                  ),
                  const SizedBox(width: 20),
                  CustomButtonChat(
                    icon: isVideoOn
                        ? Icons.videocam_outlined
                        : Icons.videocam_off_outlined,
                    color: Colors.white38,
                    onPressed: () {
                      isVideoOn = !isVideoOn;
                      setState(() {});
                    },
                  ),
                  const SizedBox(width: 20),
                  CustomButtonChat(
                    icon: Icons.messenger_outline,
                    color: AppTheme.lightGreen,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 20),
                  CustomButtonChat(
                    icon:  Icons.close,
                    color: AppTheme.red,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
