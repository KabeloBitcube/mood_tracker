import 'package:bloc/bloc.dart';
import 'package:mood_tracker/Stats_and_notifications/stats_notis.dart';

class NotificationsCubit extends Cubit<StatsNotis>{
  NotificationsCubit() : super(StatsNotis(moodEntries: [], notifications: []));

  void update (){
    emit(state);
  }
}