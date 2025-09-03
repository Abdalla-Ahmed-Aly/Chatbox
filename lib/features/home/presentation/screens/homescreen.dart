import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/features/createGroup/presentation/screens/Create_GroupScreen.dart';
import 'package:chatbox/features/home/presentation/screens/storymakerscreen.dart';
import 'package:chatbox/features/home/presentation/tabs/friendstab.dart';
import 'package:chatbox/features/home/presentation/tabs/messagetab.dart';
import 'package:chatbox/features/home/presentation/tabs/settingtab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/HomeScreen';

  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isLocked = false;
  final PageController _pageController = PageController(initialPage: 1);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      MessageTab(pageController: _pageController),
      const Center(child: Text('Search', style: TextStyle(fontSize: 24))),
      const FriendsTab(),
      const SettingTab(),
    ];
    return PageView(
      controller: _pageController,
      onPageChanged: (value) => setState(() {}),
      physics: _isLocked
          ? NeverScrollableScrollPhysics()
          : _selectedIndex != 0
          ? NeverScrollableScrollPhysics()
          : AlwaysScrollableScrollPhysics(),
      children: [
        NewStoryMakerScreen(
          pageController: _pageController,
          onImageCaptured: () {
            setState(() {
              _isLocked = !_isLocked;
            });
          },
        ),
        Scaffold(
          floatingActionButton: Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CreateGroupscreen.routeName);
              },
              icon: Icon(Icons.group_add, color: Colors.white, size: 28),
            ),
          ),

          backgroundColor: AppTheme.black,
          body: SafeArea(child: pages[_selectedIndex]),

          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/Group.svg',
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 0 ? AppTheme.lightGreen : AppTheme.gray,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/Call.svg',
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 1 ? AppTheme.lightGreen : AppTheme.gray,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/user.svg',
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 2 ? AppTheme.lightGreen : AppTheme.gray,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Friends',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/settings.svg',
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 3 ? AppTheme.lightGreen : AppTheme.gray,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
