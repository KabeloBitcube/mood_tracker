import 'dart:developer';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mood_tracker/Mood_model/moodentry.dart';

class CalendarCubit extends HydratedCubit<List<MoodEntry>> {
  CalendarCubit() : super([]);

  void setMoods(List<MoodEntry> moods){
    emit(moods);
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
    log("Moods: ${updatedList.length}");
  }

  @override
  List<MoodEntry> fromJson(Map<String, dynamic> json) {
    final list = json['moods'] as List<dynamic>;
    return list.map((item) => MoodEntry.fromMap(item)).toList();
  }

  @override
  Map<String, dynamic>? toJson(List<MoodEntry> state) {
    return {'moods': state.map((m) => m.toMap()).toList()};
  }
}
