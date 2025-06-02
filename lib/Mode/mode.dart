import 'package:flutter/material.dart';

class ModeController extends ChangeNotifier {
  // Tracks whether the app is in dark mode or light mode
  bool _isDarkMode = true;

  // Getter to check the current mode (dark or light)
  bool get isDarkMode => _isDarkMode;

  // Toggles between dark mode and light mode
  void toggleMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // Notifies listeners to rebuild UI with the updated mode
  }
}