import 'package:flutter/material.dart';
import 'package:news/screen/best_news/best_stories_view.dart';
import 'package:news/screen/hacker_news/home.dart';
import 'package:news/screen/new_stories/new_stories_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Colors.black,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarStyle: NavBarStyle.style3,
    );
  }

  List<Widget> _buildScreens() {
    return [
      const Homepage(),
      const BestStoriesScreen(),
      const NewStoriesScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        title: "Top",
        icon: const Icon(Icons.trending_up),
        activeColorPrimary: Colors.white, 
        inactiveColorPrimary: Colors.grey, 
      ),
      PersistentBottomNavBarItem(
        title: "Best",
        icon: const Icon(Icons.star),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        title: "New",
        icon: const Icon(Icons.fiber_new),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}
