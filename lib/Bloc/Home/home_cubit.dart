import 'package:bloc/bloc.dart';
import 'package:mood_tracker/Mood_model/moodentry.dart';

class MoodCubit extends Cubit<List<MoodEntry>> {
  MoodCubit() : super([]);

  void setMoods(List<MoodEntry> moods){
    emit(moods);
  }

  void addMood(MoodEntry newMood) {
    final updatedList = List<MoodEntry>.from(state);
    updatedList.add(newMood);
    emit(updatedList);
  }

  void updateMood (MoodEntry mood){
    final updatedList = state.map((mood) {
      return mood;
    }).toList();
    setMoods(updatedList);
    emit(updatedList);
  }

  void deleteMood (MoodEntry mood,List<MoodEntry> moods, int index){
    final updatedList = state.map((mood) {
      return mood;
    }).toList();
    moods.removeAt(index);
    setMoods(updatedList);
    emit(updatedList);
  }
}
