import 'package:flutter/cupertino.dart';

class CallImage extends StatelessWidget {
  const CallImage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize=MediaQuery.sizeOf(context);
    return Container(
      width: screenSize.width*.3,
height: screenSize.height*.17,
decoration: BoxDecoration(
  shape: BoxShape.circle,
  image: DecorationImage(fit: BoxFit.fill,image: AssetImage('assets/images/callImage.png')),


),

    );
  }
}
