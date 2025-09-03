import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/core/widget/customizedprofileimage.dart';
import 'package:chatbox/features/chat/presentation/screens/chatScreen.dart';
import 'package:chatbox/features/home/presentation/widgets/scrollablefrienditem.dart';
import 'package:chatbox/features/home/presentation/widgets/storywid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MessageTab extends StatelessWidget {
  MessageTab({super.key, required this.pageController});
  PageController pageController;

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
                    height: size.height * 0.05,
                  ),
                ),
                Text(
                  'Home',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: size.height * 0.065,
                  width: size.height * 0.065,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Material(
                    shape: CircleBorder(),
                    color: Colors.transparent,
                    child: InkWell(
                      customBorder: CircleBorder(),
                      onTap: () {
                        print('Tapped Profile');
                      },
                      borderRadius: BorderRadius.circular(15),
                      child: CircularProfileAvatarWidget(
                        imagePath: 'assets/images/model1.png',
                        // 'https://thfvnext.bing.com/th/id/OIP.dg2MXYDWgmIkHEF738ObUgHaOF?w=126&h=187&c=7&r=0&o=7&cb=thfvnext&dpr=2&pid=1.7&rm=3',
                        isAsset: true,
                        // size: size.height * 0.055,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// ====== Stories ======
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.04),
            child: StoryDisplay(pageController: pageController),
          ),
          SizedBox(height: verticalSpacing),

          /// ====== Message List ======
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: size.height * 0.015),
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
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
