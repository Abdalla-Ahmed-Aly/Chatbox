import 'package:chatbox/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({super.key});
static const String routeName="/qr code";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
  title: Text("QR Code"),
      ),
      body:Center(
        child: Container(
          decoration: BoxDecoration(
          ),
          child: QrImageView(
            data: 'https://github.com/Marwan9Atef',
            version: QrVersions.auto,
            size: 200,
            gapless: false,

            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size(80, 80),
            ),
            errorStateBuilder: (cxt, err) {
              return Center(
                child: Text(
                  "Uh oh! Something went wrong...",
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
      ),

    );
  }
}
