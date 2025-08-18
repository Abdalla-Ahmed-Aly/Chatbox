import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/features/home/presentation/tabs/friendstab.dart';
import 'package:chatbox/features/home/presentation/tabs/messagetab.dart';
import 'package:chatbox/features/home/presentation/tabs/settingtab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
static const String routeName='/HomeScreen';

  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of pages for each tab
  final List<Widget> _pages = [
    const MessageTab(),
    const Center(child: Text('Search', style: TextStyle(fontSize: 24))),
    const FriendsTab(),
    const SettingTab()
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black,
      body: SafeArea(child: _pages[_selectedIndex]),

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
    );
  }
}
