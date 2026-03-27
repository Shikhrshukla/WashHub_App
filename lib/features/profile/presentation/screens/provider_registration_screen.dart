import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _shopImage = File(pickedFile.path));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Logic: Send to Admin for approval
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Application submitted! Admin will review soon.")),
      );
      Navigator.pop(context);
    }
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
              const Text("Business Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // Shop Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Laundromat Name", border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // Image Picker UI
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: washubPrimaryLight,borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: washubPrimary.withValues(alpha: 0.3)),
                    ),
                    child: _shopImage == null
                        ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo, color: washubPrimary, size: 40),
                        Text("Upload Shop Photo", style: TextStyle(color: washubPrimary)),
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
                decoration: const InputDecoration(labelText: "Full Address", border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // Contact Number
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: "Business Phone", border: OutlineInputBorder()),
                validator: (v) => v!.length < 10 ? "Invalid phone" : null,
              ),

              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Submit for Review"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
