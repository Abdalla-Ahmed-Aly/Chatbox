import 'package:chatbox/features/callForChat/presentation/screens/widget/component_in_middle.dart';
import 'package:chatbox/features/callForChat/presentation/screens/widget/filterd_image.dart';
import 'package:chatbox/features/callForChat/presentation/screens/widget/row_of_ring_screen.dart';
import 'package:flutter/material.dart';

class RingScreen extends StatelessWidget {
  const RingScreen({super.key});
  static const String routeName = '/ringScreen';

  @override
  Widget build(BuildContext context) {
    Size screenSize=MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
        FilterImage(),
          Positioned(
           top: screenSize.height*.26,
              left: screenSize.width*.33,
              child:ComponentInMiddle() ),
          Positioned(
            top: screenSize.height*.751,
            right: screenSize.width*.13,
            left: screenSize.width*.13,
            child: Column(
              children: [
                RowOfRingScreen(),
                const SizedBox(
                  height: 40,
                ),

              ],


            ),
          )

        ],


      ),
    );
  }
}
