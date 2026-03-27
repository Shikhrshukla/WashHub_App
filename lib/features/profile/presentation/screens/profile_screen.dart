import 'package:flutter/material.dart';import '../../../../core/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: washubBg,
      appBar: AppBar(
        title: const Text("My Account", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Header
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: washubPrimaryLight,
              child: Icon(Icons.person, size: 50, color: washubPrimary),
            ),
          ),
          const SizedBox(height: 24),

          // 🚀 PROVIDER REGISTRATION CARD
          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: washubPrimaryLight, width: 1),
            ),
            child: ListTile(
              leading: const Icon(Icons.storefront, color: washubPrimary),
              title: const Text("Register your Laundromat",
                  style: TextStyle(fontWeight: FontWeight.bold, color: washubPrimary)),
              subtitle: const Text("Partner with us to grow your business"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: Navigate to Provider Registration Form
              },
            ),
          ),

          const SizedBox(height: 24),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.help_outline, color: Colors.grey),
            title: const Text("Help Center"),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Log Out", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}