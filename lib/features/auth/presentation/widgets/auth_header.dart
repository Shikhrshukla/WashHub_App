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
          height: 200,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: washubPrimary,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
          ),
        ),

        // 2. "Made in Gujarat" Badge (UI Reference Specific)
        Positioned(
          top: 40,
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
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}