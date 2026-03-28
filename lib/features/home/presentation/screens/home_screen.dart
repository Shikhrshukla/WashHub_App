import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'laundromat_card.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: washubBg,
      appBar: AppBar(
        title: const Text(
          "Frebulous",
          style: TextStyle(
            color: washubPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
            icon: const Icon(Icons.account_circle_outlined,
                color: Colors.black),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // 1. Location Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.location_on,
                      color: washubPrimary, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    "Bhavnagar, Gujarat",
                    style: TextStyle(
                      color: Colors.black.withValues(alpha: 0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Sticky Search Bar
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchHeaderDelegate(),
          ),

          // ✅ 3. Real-time Laundromat List
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('laundromats')
                .where('isVerified', isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }

              if (!snapshot.hasData ||
                  snapshot.data!.docs.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Text("No laundromats nearby"),
                    ),
                  ),
                );
              }

              final shops = snapshot.data!.docs;

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final data =
                    shops[index].data() as Map<String, dynamic>;

                    return LaundromatCard(
                      title: data['name'] ?? 'Frebulous Shop',
                      rating: (data['rating'] ?? 4.5).toString(),
                      promo: data['promo'] ?? "Verified Partner",
                      imageUrl: data['imageUrl'] ??
                          'https://via.placeholder.com/150',
                      address: data['address'] ?? 'Address not available',
                      phone: data['phone'] ?? 'Contact not available',
                      isVerified: data['isVerified'] ?? false,
                    );
                  },
                  childCount: shops.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Sticky Search Bar Delegate
class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Container(
      color: Colors.white,
      padding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search nearby laundromats...",
          prefixIcon:
          const Icon(Icons.search, color: washubPrimary),
          fillColor: washubBg,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
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
  bool shouldRebuild(
      covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
