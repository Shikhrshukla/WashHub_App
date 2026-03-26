import 'package:flutter/material.dart';
import '../widgets/auth_header.dart';
import '../widgets/phone_input_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose(); // Senior rule: Clean up memory
    super.dispose();
  }

  void _handleContinue() {
    final phone = _phoneController.text.trim();
    if (phone.length == 10) {
      // Success case
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sending OTP to +91 $phone")),
      );
    } else {
      // Error case
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 10-digit number")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AuthHeader(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "India's #1 Laundromat App",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  PhoneInputCard(controller: _phoneController),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _handleContinue,
                    child: const Text("Continue", style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(height: 32),
                  const Text("Or", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 24),
                  // Google Sign-In placeholder
                  GestureDetector(
                    onTap: () {},
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1200px-Google_%22G%22_logo.svg.png',
                      height: 40,
                    ),
                  ),
                  const SizedBox(height: 60),
                  const Text("By continuing, you agree to our", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  const Text(
                    "Terms of Service  Privacy Policy  Content Policy",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}