import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // 1. Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // 2. Initialize Google Sign-In (Standard initialization)
    // The plugin picks up configuration from google-services.json automatically.
    await GoogleSignIn.instance.initialize();

    runApp(const RootApp());
  } catch (e) {
    debugPrint("App Initialization Error: $e");
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(child: Text("Startup Error: $e\n\nEnsure google-services.json is correct.")),
      ),
    ));
  }
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Washub',
      debugShowCheckedModeBanner: false,
      theme: WashubTheme.lightTheme,
      home: StreamBuilder<firebase_auth.User?>(
        stream: firebase_auth.FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
