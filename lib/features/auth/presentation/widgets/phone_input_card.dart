import 'package:flutter/material.dart';

class PhoneInputCard extends StatelessWidget {
  final TextEditingController controller;

  const PhoneInputCard({super.key, required this.controller});

  @override
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
            const SizedBox(width: 12),
            // Vertical Divider
            Container(height: 24, width: 1, color: Colors.grey.shade300),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller, // Connects to the logic
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