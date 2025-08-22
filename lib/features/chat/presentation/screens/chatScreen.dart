import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/core/widget/OnlineAvatar.dart';
import 'package:chatbox/features/chat/presentation/screens/widget/SenderMessage.dart';
import 'package:chatbox/features/chat/presentation/screens/widget/resiverMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chatscreen extends StatefulWidget {
  static const String routeName = '/chatScreen';

  const Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    textEditingController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        titleSpacing: 0,

        title: Row(
          children: [
            OnlineAvatar(
              imagePath: 'assets/images/model1.png',
              isOnline: true,
              radius: 23,
              onTap: () {},
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Abdoo',
                  style: textTheme.titleLarge!.copyWith(color: AppTheme.black),
                ),
                Text(
                  'Active Now',
                  style: textTheme.bodyMedium!.copyWith(color: Colors.green),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.phone),
            iconSize: 24,
            color: AppTheme.black,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.video_camera),
            iconSize: 30,
            color: AppTheme.black,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SenderMessage(),
                    SenderMessage(),
                    SizedBox(height: 10),
                    ResiverMessage(),
                    ResiverMessage(),
                    ResiverMessage(),
                    ResiverMessage(),
                    ResiverMessage(),
                    ResiverMessage(),
                    ResiverMessage(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.paperclip,
                    color: AppTheme.black,
                    size: 26,
                  ),
                ),

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: textEditingController,
                      minLines: 1,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,

                      style: textTheme.bodyMedium!.copyWith(
                        color: AppTheme.black,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Write your message',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.photo_on_rectangle,
                            color: AppTheme.gray,
                            size: 22,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),
                if (textEditingController.text.isEmpty) ...[
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.camera,
                      color: AppTheme.black,
                      size: 26,
                    ),
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.mic,
                      color: AppTheme.black,
                      size: 26,
                    ),
                  ),
                ] else ...[
                  IconButton(
                    onPressed: () {
                      print('Send message: ${textEditingController.text}');
                      textEditingController.clear();
                    },
                    icon: Icon(
                      CupertinoIcons.arrow_up_circle_fill,
                      color: AppTheme.lightGreen,
                      size: 30,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
