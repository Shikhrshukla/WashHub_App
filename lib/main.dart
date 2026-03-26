import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // 2. Firebase Init
  await Firebase.initializeApp();

  // 3. Supabase Init
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    anonKey: 'YOUR_ANON_KEY',
  );

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Washub',
      debugShowCheckedModeBanner: false,
      theme: WashubTheme.lightTheme,
      // Abhi ke liye LoginScreen ki jagah placeholder
      home: const Scaffold(body: Center(child: Text("Washub Initialized"))),
    );
  }
}