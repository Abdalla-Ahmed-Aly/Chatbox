

import 'package:chatbox/features/callForChat/presentation/screens/widget/call_image.dart';
import 'package:flutter/material.dart';

class ComponentInMiddle extends StatelessWidget {
  const ComponentInMiddle({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme =Theme.of(context).textTheme;
    return Column(
children: [
CallImage(),
  Text("Borsha Akther",style: textTheme.headlineMedium!.copyWith(fontSize: 25),),
  const SizedBox(
    height: 8,

  ),
  Text("Incoming call",style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w500),)
  
],

    );
  }
}
