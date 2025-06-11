import 'package:bloc/bloc.dart';
import 'package:mood_tracker/Calendar/calendar.dart';

class CalendarCubit extends Cubit<CalendarScreen>{
  CalendarCubit() : super(CalendarScreen(moodEntries: []));

  void update (){
    emit(state);
  }
}