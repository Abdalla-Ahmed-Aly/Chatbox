import 'package:chatbox/features/friend/presentation/widgets/friend_request/request_list.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class FriendRequestScreen extends StatelessWidget {
  const FriendRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black,
    appBar: AppBar(title:Text("Friends Request") ,),
    body: SafeArea(
      child: Column(
          children: [
            const SizedBox(height:15,),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 10,
                        offset: Offset(0, -2),
                      ),
                    ],

                  ),
                  child:RequestList()

              ),
            )

          ],


        ),
    ),
    
    
    );
  }
}
