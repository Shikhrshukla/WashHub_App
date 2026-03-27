import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Account")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(radius: 40, backgroundColor: washubPrimaryLight, child: Icon(Icons.person, size: 40, color: washubPrimary)),
          const SizedBox(height: 24),

          // 🚀 PROVIDER REGISTRATION BUTTON
          Card(
            elevation: 0,
            color: washubPrimaryLight,
            child: ListTile(
              leading: const Icon(Icons.storefront, color: washubPrimary),
              title: const Text("Register your Laundromat", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text("Grow your business with Washub"),
              onTap: () {
                // TODO: Navigate to Registration Form
              },
            ),
          ),

          const Divider(height: 32),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Log Out", style: TextStyle(color: Colors.red)),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}