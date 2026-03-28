import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class LaundromatCard extends StatelessWidget {
  final String title;
  final String rating;
  final String promo;
  final String imageUrl;
  final String address;
  final String phone;
  final bool isVerified;

  const LaundromatCard({
    super.key,
    required this.title,
    required this.rating,
    required this.promo,
    required this.imageUrl,
    required this.address,
    required this.phone,
    this.isVerified = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Shop Image
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    color: Colors.grey.shade200,
                    child:
                    const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              ),

              // Rating Badge
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: washubAmber,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star,
                          color: Colors.white, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              // Promo Tag
              if (promo.isNotEmpty)
                Positioned(
                  bottom: 12,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    color: washubBlue,
                    child: Text(
                      promo,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + Verified
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (isVerified)
                      const Icon(Icons.verified,
                          color: washubBlue, size: 20),
                  ],
                ),

                const SizedBox(height: 6),

                // Dynamic Location + Phone
                Text(
                  "📍 $address",
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  "📞 $phone",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),

                const SizedBox(height: 12),

                // View Menu
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      // Navigate to details/menu
                    },
                    child: const Text(
                      "View Menu →",
                      style: TextStyle(
                        color: washubPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
