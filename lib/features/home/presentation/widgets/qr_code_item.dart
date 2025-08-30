import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeItem extends StatelessWidget {
  const QrCodeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  QrImageView(
      data: 'https://github.com/Marwan9Atef',
      version: QrVersions.auto,
      size: 200,
      gapless: false,
      embeddedImage: AssetImage("assets/images/cBAW.png"),
      embeddedImageStyle: QrEmbeddedImageStyle(
        size: Size(50, 50),
      ),
      errorStateBuilder: (cxt, err) {
        return Center(
          child: Text(
            "Uh oh! Something went wrong...",
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
