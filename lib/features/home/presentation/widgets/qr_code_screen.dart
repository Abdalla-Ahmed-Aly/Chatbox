import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/features/home/presentation/widgets/qr_code_item.dart';
import 'package:flutter/material.dart';



class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({super.key});
static const String routeName="/qr code";
  @override
  Widget build(BuildContext context) {
    Size screenSize=MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppTheme.primary.withValues(alpha: .98),
      appBar: AppBar(
        backgroundColor: AppTheme.primary,

  title: Text("QR Code"),
      ),
      body:Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: screenSize.width*.4,
              height: screenSize.height*.2,
                color: AppTheme.primary,
              child:QrCodeItem()
            ),
          ),
        ],
      ),

    );
  }
}
