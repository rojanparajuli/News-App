import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/navigation/navigation_convix.dart';
import 'package:news/screen/best_news/best_stories_view.dart';
import 'package:news/screen/hacker_news/home.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit, int>(
        builder: (context, selectedIndex) {
          Widget page;
          switch (selectedIndex) {
            case 0:
              page = const Homepage();
              break;
            case 1:
              page = const BestStoriesScreen();
              break;
           
            default:
              page = const Homepage();
          }
          return page;
        },
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.white,
        items: const [
          TabItem(
            icon: Icon(Icons.home, color: Colors.blue),
            title: 'Home',
          ),
          TabItem(
            icon: Icon(Icons.widgets),
            title: 'Recent',
          ),
         
        ],
        initialActiveIndex: context.read<NavigationCubit>().state,
        
        onTap: (index) => context.read<NavigationCubit>().changeTab(index),
      ),
    );
  }
}
