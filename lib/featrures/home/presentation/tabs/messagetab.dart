import 'package:chatbox/featrures/home/presentation/widgets/scrollablefrienditem.dart';
import 'package:chatbox/featrures/home/presentation/widgets/storywid.dart';
import 'package:chatbox/utils/theme/apptheme.dart';
import 'package:flutter/material.dart';

class MessageTab extends StatelessWidget {
  const MessageTab({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: 40),
        Padding(padding: EdgeInsets.only(left: 16.0), child: StoryDisplay()),
        SizedBox(height: 20),
        Container(
          height: size.height * 0.56265,
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            color: AppTheme.primary,
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,

                  itemBuilder: (context, index) {
                    return CustomSlidableMessageItem(
                      onTap: () {
                        print('Tapped Ghareeb');
                      },
                      onMute: () {
                        print('Muted Ghareeb');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Muted Ghareeb'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      onDelete: () {
                        print('Deleted Ghareeb');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Deleted Ghareeb'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
