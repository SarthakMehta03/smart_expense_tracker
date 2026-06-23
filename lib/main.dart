import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:smart_expense_tracker/screens/home/dashboard_screen.dart';
import 'package:smart_expense_tracker/screens/home/home_screen.dart';
import 'package:smart_expense_tracker/widgets/greeting_card.dart';
import 'package:smart_expense_tracker/widgets/stats_row.dart';
import 'package:smart_expense_tracker/widgets/transaction_tile.dart';

import 'firebase_options.dart';

import 'providers/theme_provider.dart';
import 'theme/light_theme.dart';
import 'theme/dark_theme.dart';

import 'screens/auth/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider =
    Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Expense Tracker',

      theme: AppThemes.lightTheme,
      darkTheme: DarkAppTheme.darkTheme,

      themeMode: themeProvider.isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,

      home: const LoginScreen(),
    );
  }
}