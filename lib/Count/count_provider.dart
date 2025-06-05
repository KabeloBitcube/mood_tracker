import 'package:flutter/material.dart';

class CountProvider extends ChangeNotifier{
  int count = 0;

  void getNotificationCount (int currentCount){
    count = currentCount;
    notifyListeners();
  }

  int get notificationCount => count;
}