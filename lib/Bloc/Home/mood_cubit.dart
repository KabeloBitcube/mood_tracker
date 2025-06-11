import 'package:bloc/bloc.dart';
import 'package:mood_tracker/Mood_model/moodentry.dart';

class MoodCubit extends Cubit<MoodEntry> {
  MoodCubit()
    : super(
        MoodEntry(
          mood: '',
          reason: '',
          description: '',
          timeOfDay: 0,
          date: DateTime.now(),
        ),
      );

    void update(){
      emit(state);
    }
}
