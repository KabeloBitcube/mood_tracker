import 'package:bloc/bloc.dart';

class NotificationsCubit extends Cubit<List<String>>{
  NotificationsCubit() : super(['']);

  void deleteNotifications (List<String> notifications){
    notifications.clear();
    emit(notifications);
  }
}