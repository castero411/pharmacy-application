import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:medicine_manager/UI/Pages/account_page/account_page.dart';

import 'package:medicine_manager/UI/Pages/add_medicine/add_medicine.dart';
import 'package:medicine_manager/UI/Pages/display_page/display_page.dart';
import 'package:medicine_manager/UI/Pages/edit_account_page/edit_account_page.dart';
import 'package:medicine_manager/UI/Pages/login_page/login_page.dart';
import 'package:medicine_manager/UI/Pages/main_page/main_page.dart';
import 'package:medicine_manager/UI/Pages/notifications_page/notifications_page.dart';
import 'package:medicine_manager/UI/Pages/settings_page/settings_page.dart';
import 'package:medicine_manager/UI/Pages/signup%20page/signup_page.dart';
import 'package:medicine_manager/UI/Provider/provider.dart';

import 'package:medicine_manager/UI/Theme/theme.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();

  runApp(ProviderScope(child: const MedicalApp()));
}

class MedicalApp extends ConsumerStatefulWidget {
  const MedicalApp({super.key});

  @override
  ConsumerState<MedicalApp> createState() => _MedicalAppState();
}

class _MedicalAppState extends ConsumerState<MedicalApp> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Pausing for splash screen

    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(displaySwitchProvider);

    return Consumer(
      builder: (context, ref, _) {
        // We load the user from SharedPreferences
        final FirebaseAuth auth = FirebaseAuth.instance;

        User? user = auth.currentUser;

        // If no user is found, navigate to the login page, otherwise to the main page
        return MaterialApp(
          theme: isDarkMode ? darkTheme : lightTheme,
          home: user == null ? LoginPage() : MainPage(),
          routes: {
            'login_page': (context) => LoginPage(),
            'signup_page': (context) => SignupPage(),
            'main_page': (context) => MainPage(),
            'settings': (context) => SettingsPage(),
            'notifications': (context) => NotificationsPage(),
            'display': (context) => DisplayPage(),
            'add_medicine': (context) => AddMedicine(),
            'account_page': (context) => AccountPage(),
            'edit_account_page': (context) => EditAccountPage(),
          },
        );
      },
    );
  }
}
