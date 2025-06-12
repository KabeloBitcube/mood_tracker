import 'package:bloc/bloc.dart';
import 'package:mood_tracker/Mood_model/moodentry.dart';

class CalendarCubit extends Cubit<MoodEntry> {
  CalendarCubit()
    : super(
        MoodEntry(
          mood: '',
          reason: '',
          description: '',
          timeOfDay: 0,
          date: DateTime.now(),
        ),
      );

  void update (MoodEntry entry) {
    emit(entry);
  }
}
