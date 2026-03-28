import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/theme/app_theme.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Partner Approvals"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('laundromats')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return const Center(child: Text("No requests found"));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data() as Map<String, dynamic>;
              final bool isVerified = data['isVerified'] ?? false;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            data['imageUrl'] ?? '',
                            width: 60, height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, _, __) => Container(
                              width: 60, height: 60, color: Colors.grey.shade200,
                              child: const Icon(Icons.store),
                            ),
                          ),
                        ),
                        title: Text(data['name'] ?? 'Unnamed', style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(data['address'] ?? 'No address', maxLines: 2),
                        trailing: isVerified 
                          ? const Icon(Icons.verified, color: Colors.blue)
                          : const Icon(Icons.pending, color: Colors.orange),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Delete Button
                          TextButton.icon(
                            onPressed: () => _confirmDelete(context, doc.id),
                            icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                            label: const Text("Delete", style: TextStyle(color: Colors.red)),
                          ),
                          const SizedBox(width: 8),
                          // Approve Button (only if not verified)
                          if (!isVerified)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: washubPrimary,
                                minimumSize: const Size(100, 36),
                              ),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('laundromats')
                                    .doc(doc.id)
                                    .update({'isVerified': true});
                              },
                              child: const Text("Approve"),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Remove Laundromat?"),
        content: const Text("This will permanently delete this partner from the database."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await FirebaseFirestore.instance.collection('laundromats').doc(docId).delete();
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
