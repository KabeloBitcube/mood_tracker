import 'package:flutter/material.dart';

class ReasonController extends ChangeNotifier {
  // Tracks whether a container has been selected or not
  bool _isSelected = false;

  // Getter to check the current state (true or false)
  bool get isSelected => _isSelected;

  // Toggles between selected and not selected
  void toggleReason() {
    _isSelected = !_isSelected;
    notifyListeners(); // Notifies listeners to rebuild UI with the updated state
  }
}