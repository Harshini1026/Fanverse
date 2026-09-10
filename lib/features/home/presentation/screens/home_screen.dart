import 'package:fan_verse/features/home/presentation/widgets/home_header.dart';
import 'package:fan_verse/features/home/presentation/widgets/home_search_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      
        body: Column(
          children: [
            HomeHeader(),
            HomeSearchBar(),
          ],
        ),
      ),
    );
  }
}