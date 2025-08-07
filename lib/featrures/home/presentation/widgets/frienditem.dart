import 'package:chatbox/utils/theme/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FriendItem extends StatefulWidget {
  const FriendItem({super.key});

  @override
  State<FriendItem> createState() => _FriendItemState();
}

class _FriendItemState extends State<FriendItem> {
  double offsetX = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.black,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset('assets/svg/notification.svg'),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.red,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset('assets/svg/Vector.svg'),
                ),
              ],
            ),
          ),
        ),
        Dismissible(
          key: ValueKey(1),
          direction: DismissDirection.endToStart,
          confirmDismiss: (_) async {
            return false;
          },
          onUpdate: (details) {
            setState(() {
              offsetX = -details.progress * 100;
            });
          },
          child: Transform.translate(
            offset: Offset(offsetX, 0),
            child: SizedBox(
              height: size.height * 0.1,
              child: Material(
                color: AppTheme.primary,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/image/model1.png'),
                  ),
                  title: Text(
                    'Ghareeb',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(color: AppTheme.black),
                  ),
                  subtitle: Text(
                    'Hello',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppTheme.gray),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '2 min ago',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: AppTheme.gray),
                      ),
                      SizedBox(height: 5),
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: AppTheme.red,
                        child: Text(
                          '1',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppTheme.primary, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
