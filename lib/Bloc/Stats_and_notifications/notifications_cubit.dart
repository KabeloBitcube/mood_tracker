import 'package:bloc/bloc.dart';

class NotificationsCubit extends Cubit<List<String>>{
  NotificationsCubit() : super(['']);

  void update (List<String> notifications){
    notifications.clear();
    emit(notifications);
  }
}