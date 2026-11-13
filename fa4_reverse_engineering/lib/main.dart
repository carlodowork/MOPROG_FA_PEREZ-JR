import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/app_constants.dart';
import 'screens/home_screen.dart';  
import 'state/inventory_store.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => InventoryStore(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,   
      debugShowCheckedModeBanner: false,  
      theme: AppTheme.light,
      home: const HomeScreen(),
    );
  }
}