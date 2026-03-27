import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: washubBg,
      body: CustomScrollView(
        slivers: [
          // 1. Top Bar with Location
          SliverAppBar(
            floating: true,
            title: const Text("India", style: TextStyle(color: washubPrimary)),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            ],
          ),

          // 2. Search Bar Placeholder
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search nearby you",
                  prefixIcon: const Icon(Icons.search),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}