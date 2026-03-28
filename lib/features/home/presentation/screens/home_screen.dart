import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/widgets/laundromat_card.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: washubBg,
      body: CustomScrollView(
        slivers: [
          // 1. Production Sliver App Bar
          SliverAppBar(
            pinned: true,
            expandedHeight: 100,
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: Row(
                children: [
                  const Icon(Icons.location_on, color: washubPrimary, size: 16),
                  const SizedBox(width: 4),
                  Text("Bhavnagar, Gujarat",
                      style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 14)),
                ],
              ),
            ),
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

          // 2. Sticky Search Bar
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchHeaderDelegate(),
          ),

          // 3. Laundromat List
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => const LaundromatCard(
                title: "Washub Magic Care",
                rating: "4.9",
                promo: "10% Off",
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
