import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/core/widget/OnlineAvatar.dart';
import 'package:chatbox/features/chat/presentation/screens/widget/SenderMessage.dart';
import 'package:chatbox/features/chat/presentation/screens/widget/playRecord.dart';
import 'package:chatbox/features/chat/presentation/screens/widget/resiverMessage.dart';
import 'package:chatbox/features/chat/presentation/screens/widget/testMic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chatscreen extends StatefulWidget {
  static const String routeName = '/chatScreen';

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final AudioRecorderHelper _recorderHelper = AudioRecorderHelper();
  bool isRecordingActive = false;

  bool isRecording = false;
  String? recordedAudioPath;

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(() {
      setState(() {});
    });
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void onSendMessage() {
    final message = textEditingController.text.trim();
    if (message.isNotEmpty) {
      print('Send message: $message');
      textEditingController.clear();
      scrollToBottom();
    }
  }

  Future<void> startRecording() async {
    bool granted = await _recorderHelper.requestPermissions();
    if (!granted) {
      // ممكن تظهر رسالة للمستخدم إن السماحية مرفوضة
      return;
    }
    await _recorderHelper.startRecording();
    setState(() {
      isRecording = true;
      recordedAudioPath = null; // لما يبدأ تسجيل جديد، نلغي القديم
    });
  }

  Future<void> stopRecording() async {
    await _recorderHelper.stopRecording();
    setState(() {
      isRecording = false;
      recordedAudioPath = _recorderHelper.lastRecordedFilePath;
    });
  }

  @override
  void dispose() {
    // لو AudioRecorderHelper عنده dispose() فعلها هنا
    // _recorderHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
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
              child: ListView(
                controller: scrollController,
                reverse: true,
                children: [
                  ResiverMessage(),
                  ResiverMessage(),
                  ResiverMessage(),
                  ResiverMessage(),
                  ResiverMessage(),
                  ResiverMessage(),
                  ResiverMessage(),
                  const SizedBox(height: 10),
                  SenderMessage(),
                  SenderMessage(),
                ],
              ),
            ),
          ),

          // عرض مشغل الصوت لو في تسجيل
          if (recordedAudioPath != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: InstagramStyleAudioPlayer(audioPath: recordedAudioPath!),
            ),
          ],

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                      onTapOutside: (_) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
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
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),

                if (textEditingController.text.isEmpty) ...[
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.camera,
                      color: AppTheme.black,
                      size: 26,
                    ),
                  ),
                  GestureDetector(
                    onLongPress: () async {
                      await startRecording();
                      setState(() => isRecordingActive = true);
                    },
                    onLongPressUp: () async {
                      await stopRecording();
                      setState(() => isRecordingActive = false);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isRecordingActive
                            ? Colors.red.shade600
                            : Colors.grey.shade300,
                        shape: BoxShape.circle,
                        boxShadow: isRecordingActive
                            ? [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.6),
                                  blurRadius: 12,
                                  spreadRadius: 1,
                                ),
                              ]
                            : [],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            CupertinoIcons.mic,
                            color: isRecordingActive
                                ? Colors.white
                                : Colors.black87,
                            size: 28,
                          ),
                          if (isRecordingActive)
                            Positioned(
                              top: -28,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade600,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.7),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: const Text(
                                  "Recording...",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  GestureDetector(
                    onTap: onSendMessage,
                    child: Icon(
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
