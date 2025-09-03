import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class AudioRecorderHelper {
final record = AudioRecorder();
  String? lastRecordedFilePath; 

  Future<bool> requestPermissions() async {
    var micStatus = await Permission.microphone.status;

    if (!micStatus.isGranted) {
      micStatus = await Permission.microphone.request();
    }

    return micStatus.isGranted;
  }

  Future<String> _getFilePath() async {
    final directory = Directory('/storage/emulated/0/Recordings');

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    final filePath =
        '${directory.path}/my_record_${DateTime.now().millisecondsSinceEpoch}.m4a';

    return filePath;
  }

  Future<void> startRecording() async {
    if (await requestPermissions() && await record.hasPermission()) {
      final path = await _getFilePath();

       await record.start(const RecordConfig(), path: path);


      print('🎙️ Recording started to: $path');
    } else {
      print('❌ Permission not granted');
    }
  }

  Future<void> stopRecording() async {
    final path = await record.stop();
        lastRecordedFilePath = path; 

    if (path != null) {
      print('✅ Recording saved to: $path');

      final file = File(path);
      if (await file.exists()) {
        print('📂 File exists: ${await file.length()} bytes');
      } else {
        print('❌ File not found!');
      }
    } else {
      print('❌ No path returned from stop()');
    }
  }

  Future<void> pauseRecording() async {
    await record.pause();
    print('⏸️ Recording paused');
  }

  Future<void> resumeRecording() async {
    await record.resume();
    print('▶️ Recording resumed');
  }
  
}
