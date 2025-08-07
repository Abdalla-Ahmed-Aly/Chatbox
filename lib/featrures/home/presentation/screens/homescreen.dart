import 'package:chatbox/featrures/home/presentation/tabs/messagetab.dart';
import 'package:chatbox/utils/theme/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of pages for each tab
  final List<Widget> _pages = [
    MessageTab(),
    const Center(child: Text('Search', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Favorites', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Profile', style: TextStyle(fontSize: 24))),
  ];
  final List<String> _tabLabels = ['Home', 'Calls', 'Contacts', 'Settings'];

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
                _selectedIndex == 0 ? AppTheme.lightgreen : AppTheme.gray,
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/Call.svg',
              colorFilter: ColorFilter.mode(
                _selectedIndex == 1 ? AppTheme.lightgreen : AppTheme.gray,
                BlendMode.srcIn,
              ),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/user.svg',
              colorFilter: ColorFilter.mode(
                _selectedIndex == 2 ? AppTheme.lightgreen : AppTheme.gray,
                BlendMode.srcIn,
              ),
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/settings.svg',
              colorFilter: ColorFilter.mode(
                _selectedIndex == 3 ? AppTheme.lightgreen : AppTheme.gray,
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
