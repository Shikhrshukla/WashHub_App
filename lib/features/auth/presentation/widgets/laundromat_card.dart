import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class LaundromatCard extends StatelessWidget {
  final String title;
  final String rating;
  final String promo;

  const LaundromatCard({
    super.key,
    required this.title,
    required this.rating,
    required this.promo
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // 1. Image Placeholder (Use real URL in production)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  'https://images.unsplash.com/photo-1545173168-9f1947eebb7f?q=80&w=500',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // 2. Rating Badge (Amber)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: washubAmber,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(rating, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              // 3. Promo Badge (Blue)
              Positioned(
                bottom: 12,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  color: washubBlue,
                  child: Text(promo, style: const TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text("📍 x1750 Orders picked from here", style: TextStyle(color: Colors.grey, fontSize: 12)),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Text("View More", style: TextStyle(color: washubPrimary, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}