import 'package:bloc/bloc.dart';

class NotificationsCubit extends Cubit<List<String>>{
  NotificationsCubit() : super(['']);

  Future<void> deleteNotifications (List<String> notifications) async{
    notifications.clear();
    emit(notifications);
  }
}