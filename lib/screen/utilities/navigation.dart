import 'package:flutter/material.dart';
import 'package:news/screen/best_news/best_stories_view.dart';
import 'package:news/screen/hacker_news/home.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Colors.white, 
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarStyle: NavBarStyle.style6,
    );
  }

  List<Widget> _buildScreens() {
    return [
      const Homepage(),
      const BestStoriesScreen(),
      const Center(child: Text("Settings")),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        title: "Top Stories",
        icon: Icon(Icons.newspaper),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        title: "Best Stories",
        icon: Icon(Icons.newspaper),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: "Settings",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}
