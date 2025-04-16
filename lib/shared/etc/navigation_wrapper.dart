import 'package:flutter/material.dart';
import 'package:khromov/features/feed/presentation/feed_screen.dart';
import 'package:khromov/features/home/presentation/home_screen.dart';
import 'package:khromov/features/scannr/scannr_scrn.dart';
import 'package:khromov/features/services/presentation/services_screen.dart';
import 'package:khromov/features/settings/settings_screen.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({super.key});

  @override
  _NavigationWrapperState createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ScannrScrn(),
    const FeedScreen(),
    // const ServicesScreen(),
    const SettingsScreen(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.qr_code_scanner),
      label: 'Сканер',
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.history), label: 'История'),
    // const BottomNavigationBarItem(
    //   icon: Icon(Icons.business_center),
    //   label: 'Сервисы',
    // ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Настройки',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _bottomNavBarItems,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.purple.shade300,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
