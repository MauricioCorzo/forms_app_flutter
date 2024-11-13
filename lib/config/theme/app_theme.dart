import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() {
    const seedColor = Colors.deepPurple;
    return ThemeData(
        useMaterial3: true,
        colorSchemeSeed: seedColor,
        appBarTheme: const AppBarTheme(centerTitle: false),
        listTileTheme: const ListTileThemeData(
          iconColor: seedColor,
        ));
  }
}
