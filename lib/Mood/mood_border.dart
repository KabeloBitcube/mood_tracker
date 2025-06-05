import 'package:flutter/material.dart';

class BorderController extends ChangeNotifier {
  // Tracks whether the app is in dark mode or light mode
  bool _isSelected = false;

  // Getter to check the current mode (dark or light)
  bool get isSelected => _isSelected;

  // Toggles between dark mode and light mode
  void toggleMode() {
    _isSelected = !_isSelected;
    notifyListeners(); // Notifies listeners to rebuild UI with the updated mode
  }
}