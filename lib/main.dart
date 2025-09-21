import 'package:flutter/material.dart';
import 'chat_box.dart';
import 'core/di/service_locator.dart';
import 'core/init/observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsBinding.instance.deferFirstFrame();
  observerInit();
  await configureDependencies();
  runApp(ChatBox());

  WidgetsBinding.instance.allowFirstFrame();
}
