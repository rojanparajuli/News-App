import 'package:flutter/material.dart';
import 'package:news/animation/loading/widget/shimmer_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 8, 
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ShimmerLoadingCard(),
            );
          },
        ),
      ),
    );
  }
}
