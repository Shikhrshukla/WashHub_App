import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class PhoneInputCard extends StatelessWidget {
  const PhoneInputCard({super.key});@override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            const Icon(Icons.person, color: Colors.grey),
            const SizedBox(width: 12),
            const Text("+91", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Container(
              height: 24,
              width: 1,
              color: Colors.grey.shade300,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "Enter Mobile Number",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}