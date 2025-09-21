import 'package:chatbox/core/di/service_locator.dart';
import 'package:chatbox/core/route/route_center.dart';
import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/core/widget/online_avatar.dart';
import 'package:chatbox/features/chat/domain/use_cases/getUserProfile.dart';
import 'package:chatbox/features/chat/presentation/cubit/get_user_profile_cubit.dart';
import 'package:chatbox/features/chat/presentation/screens/widget/sender/SenderMessage.dart';
import 'package:chatbox/features/chat/presentation/screens/widget/resiver/resiverMessage.dart';
import 'package:chatbox/features/chat/presentation/screens/widget/testMic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final AudioRecorderHelper _recorderHelper = AudioRecorderHelper();
  bool isRecordingActive = false;

  bool isRecording = false;
  String? recordedAudioPath;
  String? recordedImagePath;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    serviceLocator.get<GetUserProfileCubit>()..getUserProfile(Params('Abdoo'));

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

  Future<void> pickImage() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (picked != null) {
        setState(() {
          recordedImagePath = picked.path;
        });
        scrollToBottom();
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  List<Widget> messages = [
    ResiverMessage(text: 'hi Abdoo'),
    SenderMessage(text: 'Hi Ahmed'),
  ];
  void onSendMessage() {
    final message = textEditingController.text.trim();
    if (message.isNotEmpty) {
      print('Send message: $message');
      textEditingController.clear();
      scrollToBottom();
    }
  }

  Future<void> captureImage() async {
    try {
      final XFile? captured = await _picker.pickImage(
        source: ImageSource.camera,
      );
      if (captured != null) {
        setState(() {
          recordedImagePath = captured.path;
          messages.add(SenderMessage(imagePath: recordedImagePath));
        });
        scrollToBottom();
      }
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  Future<void> startRecording() async {
    bool granted = await _recorderHelper.requestPermissions();
    if (!granted) {
      return;
    }
    await _recorderHelper.startRecording();
    setState(() {
      isRecording = true;
      recordedAudioPath = null;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // if (recordedAudioPath != null) {
    //   messages.add(ResiverMessage(audioPath: recordedAudioPath));
    //   messages.add(SenderMessage(audioPath: recordedAudioPath));
    // }

    if (recordedImagePath != null) {
      messages.add(
        ResiverMessage(
          imagePath: recordedImagePath,
          audioPath: recordedAudioPath,
        ),
      );
      messages.add(SenderMessage(imagePath: recordedImagePath));
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.back),
          color: AppTheme.black,
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            OnlineAvatar(
              imagePath: 'assets/images/model1.png',
              isOnline: true,
              radius: 23,
              onTap: () {
                context.push(RouteCenter.profileScreenUser, extra: "Abdoo");
              },
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
            onPressed: () {
              context.push(RouteCenter.ringScreen);
            },
            icon: const Icon(CupertinoIcons.phone),
            iconSize: 24,
            color: AppTheme.black,
          ),
          IconButton(
            onPressed: () {
              context.push(RouteCenter.ringScreen);
            },
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
                children: messages.reversed.toList(),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.white,
            child: Row(
              children: [
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(
                //     CupertinoIcons.paperclip,
                //     color: AppTheme.black,
                //     size: 26,
                //   ),
                // ),
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
                          onPressed: () async {
                            await pickImage();
                          },
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
                    onPressed: () {
                      captureImage();
                    },
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
                                  color: Colors.red.withValues(alpha: 0.6),
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
                                      color: Colors.red.withValues(alpha: 0.7),
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
