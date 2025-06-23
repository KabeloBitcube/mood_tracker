
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsCubit extends Cubit<List<String>> {
  static const _storageKey ='notification__count';
  NotificationsCubit() : super(['']){
    _loadNotifications();
  }

  Future<void> addNotifaction(String newNotification) async {
    final updatedList = List<String>.from(state);
    updatedList.add(newNotification);
    emit(updatedList);
    _saveNotifications(updatedList);
  }

  Future<void> deleteNotifications(List<String> notifications) async {
    notifications.clear();
    emit(notifications);
    _saveNotifications(notifications);
    _loadNotifications();
  }

  Future<void> _saveNotifications(List<String> notifications) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = notifications.map((notification) => jsonEncode(notification)).toList();
    await prefs.setStringList(_storageKey, jsonList);
  }

  Future<void> _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final notifications = prefs.getStringList(_storageKey);
    if (notifications != null) {
      emit(notifications);
    }
  }
}
