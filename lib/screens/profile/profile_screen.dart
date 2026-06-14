import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final themeProvider =
    Provider.of<ThemeProvider>(context);

    return ListView(
      children: [

        const SizedBox(height: 20),

        const Icon(
          Icons.person,
          size: 100,
        ),

        const SizedBox(height: 20),

        SwitchListTile(
          title: const Text("Dark Mode"),
          value: themeProvider.isDarkMode,
          onChanged: (value) {
            themeProvider.toggleTheme();
          },
        ),
      ],
    );
  }
}