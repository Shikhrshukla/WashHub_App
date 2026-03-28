import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/auth_header.dart';
import '../widgets/phone_input_card.dart';
import '../../../../features/home/presentation/screens/home_screen.dart';
import 'otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    final phone = _phoneController.text.trim();
    if (phone.length == 10) {
      context.read<AuthBloc>().add(SendOTPEvent(phone));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 10-digit number")),
      );
    }
  }

  // Dedicated Admin Login Dialog
  void _showAdminLogin() {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Admin Secure Login"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Admin Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );
                if (context.mounted) {
                  Navigator.pop(context); // Close dialog
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Invalid Admin Credentials")),
                );
              }
            },
            child: const Text("Login"),
          ),
        ],
      ),
    );
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

                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthCodeSent) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("OTP Sent Successfully!")),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpScreen(
                              verificationId: state.verificationId,
                            ),
                          ),
                        );
                      } else if (state is AuthSuccess) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                          (route) => false,
                        );
                      } else if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message), backgroundColor: Colors.red),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CircularProgressIndicator();
                      }
                      return ElevatedButton(
                        onPressed: _handleContinue,
                        child: const Text("Continue", style: TextStyle(fontSize: 18)),
                      );
                    },
                  ),

                  const SizedBox(height: 32),
                  const Text("Or", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 24),
                  
                  // Google Sign-In Button
                  GestureDetector(
                    onTap: () {
                      context.read<AuthBloc>().add(GoogleSignInEvent());
                    },
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
                  
                  // Hidden Admin Entry
                  const SizedBox(height: 40),
                  TextButton(
                    onPressed: _showAdminLogin,
                    child: Text(
                      "Staff Login",
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
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
