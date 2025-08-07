import 'package:chatbox/featrures/home/presentation/screens/homescreen.dart';
import 'package:chatbox/utils/theme/apptheme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ChatBox());
}

class ChatBox extends StatelessWidget {
  const ChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darktheme,
      home: HomeScreen(),
      // routes: {Splashscreen.routeName: (_) => Splashscreen()},
      // initialRoute: Splashscreen.routeName,
    );
  }
}
