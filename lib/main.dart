import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'chat_box.dart';
import 'core/di/service_locator.dart';
import 'core/init/observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsBinding.instance.deferFirstFrame();
  observerInit();
  await configureDependencies();
   await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(ChatBox());

  WidgetsBinding.instance.allowFirstFrame();
}
