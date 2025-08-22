import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/features/chat/presentation/screens/chatScreen.dart';
import 'package:chatbox/features/home/presentation/widgets/scrollablefrienditem.dart';
import 'package:chatbox/features/home/presentation/widgets/storywid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MessageTab extends StatefulWidget {
  const MessageTab({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<MessageTab> createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double verticalSpacing = size.height * 0.025;

    return SafeArea(
      child: Column(
        children: [
          /// ====== Header ======
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: verticalSpacing,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/svg/Group 370.svg',
                    height: size.height * 0.035,
                  ),
                ),
                Text(
                  'Home',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    print('Tapped Profile');
                  },
                  borderRadius: BorderRadius.circular(15),
                  child: CircleAvatar(
                    radius: size.width * 0.055,
                    backgroundImage: AssetImage(
                      'assets/images/Ellipse 307.png',
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// ====== Stories ======
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.04),
            child: StoryDisplay(pageController: widget.pageController),
          ),
          SizedBox(height: verticalSpacing),

          /// ====== Message List ======
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: size.height * 0.015),
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size.width * 0.1),
                  topRight: Radius.circular(size.width * 0.1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: size.width * 0.1,
                    height: size.height * 0.005,
                    margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.01,
                        vertical: size.height * 0.01,
                      ),
                      itemCount: 10,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: size.height * 0.01),
                      itemBuilder: (context, index) {
                        return CustomSlidableMessageItem(
                          onTap: () {
                            Navigator.pushNamed(context, Chatscreen.routeName);
                            print('Tapped Ghareeb');
                          },
                          onMute: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Muted Ghareeb'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          onDelete: () {
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
          ),
        ],
      ),
    );
  }
}
