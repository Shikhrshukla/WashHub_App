import 'package:flutter/material.dart';
import '../widgets/auth_header.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/phone_input_card.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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

                  const PhoneInputCard(),                 //phone_input_card.dart
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement OTP Trigger
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),

                  const SizedBox(height: 32),
                  const Text("Or", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 24),

                  // Social Login Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => {}, // TODO: Google Sign In
                        child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1200px-Google_%22G%22_logo.svg.png',
                          height: 40,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 60),

                  // Terms and Policy Footer
                  const Text(
                    "By continuing, you agree to our",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const Text(
                    "Terms of Service  Privacy Policy  Content Policy",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
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