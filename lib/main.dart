import 'package:chatbox/splashScreen.dart';
import 'package:chatbox/utils/theme/apptheme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ChatBox());
}

class ChatBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darktheme,
      routes: {Splashscreen.routeName: (_) => Splashscreen()},
      initialRoute: Splashscreen.routeName,
    );
  }
}
