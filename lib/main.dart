import 'package:flutter/material.dart';
import 'chat_box.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsBinding.instance.deferFirstFrame();

  runApp(ChatBox());

  WidgetsBinding.instance.allowFirstFrame();
}


