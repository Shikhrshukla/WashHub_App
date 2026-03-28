import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'laundromat_card.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: washubBg,
      appBar: AppBar(
        title: const Text("Frebulous", style: TextStyle(color: washubPrimary, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none, color: Colors.black)
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
              icon: const Icon(Icons.account_circle_outlined, color: Colors.black)
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // 1. Production Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: washubPrimary, size: 16),
                  const SizedBox(width: 4),
                  Text("Bhavnagar, Gujarat",
                      style: TextStyle(color: Colors.black.withValues(alpha: 0.8), fontSize: 14)),
                ],
              ),
            ),
          ),

          // 2. Sticky Search Bar
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchHeaderDelegate(),
          ),

          // 3. Laundromat List
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => const LaundromatCard(
                title: "Frebulous Magic Care",
                rating: "4.9",
                promo: "10% Off", imageUrl: '',
              ),
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}

// Search Bar Delegate for "Sticky" effect
class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search nearby laundromats...",
          prefixIcon: const Icon(Icons.search, color: washubPrimary),
          fillColor: washubBg,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 70;
  @override
  double get minExtent => 70;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
