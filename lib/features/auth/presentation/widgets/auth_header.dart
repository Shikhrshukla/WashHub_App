import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Background Teal Container
        Container(
          height: 220,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: washubPrimary,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Frebulous Logo Placeholder
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.local_laundry_service_rounded,
                  color: Colors.white,
                  size: 60,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "FREBULOUS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),

        // 2. Badge
        Positioned(
          top: 50,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
            ),
            child: const Text(
              "Made in Gujarat",
              style: TextStyle(
                color: washubPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
