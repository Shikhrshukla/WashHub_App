import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// Firebase imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProviderRegistrationScreen extends StatefulWidget {
  const ProviderRegistrationScreen({super.key});

  @override
  State<ProviderRegistrationScreen> createState() => _ProviderRegistrationScreenState();
}

class _ProviderRegistrationScreenState extends State<ProviderRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  File? _shopImage;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _shopImage = File(pickedFile.path));
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    if (_shopImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload a shop photo")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('laundromats/${user!.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg');

      await storageRef.putFile(_shopImage!);
      final imageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance.collection('laundromats').add({
        'name': _nameController.text.trim(),
        'address': _addressController.text.trim(),
        'phone': _phoneController.text.trim(),
        'imageUrl': imageUrl,
        'ownerUid': user.uid,
        'isVerified': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Application submitted! Admin will review soon.")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register Laundromat")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Business Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Shop Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Laundromat Name",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // Image Picker
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: washubPrimaryLight,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: washubPrimary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: _shopImage == null
                        ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo, color: washubPrimary, size: 40),
                        Text(
                          "Upload Shop Photo",
                          style: TextStyle(color: washubPrimary),
                        ),
                      ],
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(_shopImage!, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Address
              TextFormField(
                controller: _addressController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Full Address",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // Phone
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Business Phone",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.length < 10 ? "Invalid phone" : null,
              ),

              const SizedBox(height: 32),

              // Submit Button with Loader
              SizedBox(
                width: double.infinity,
                child:               ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Submit for Review"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}