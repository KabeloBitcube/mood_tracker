// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

//Mood entry class

class MoodEntry {
  final String mood;
  String reason;
  String description;
  final int? timeOfDay;
  final DateTime date;

  MoodEntry({
    required this.mood,
    required this.reason,
    required this.description,
    required this.timeOfDay,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mood': mood,
      'reason': reason,
      'description': description,
      'timeOfDay': timeOfDay,
      'date': date.toIso8601String(),
    };
  }

  factory MoodEntry.fromMap(Map<String, dynamic> map) {
    return MoodEntry(
      mood: map['mood'],
      reason: map['reason'],
      description: map['description'],
      timeOfDay: map['timeOfDay'],
      date: DateTime.parse(map['date']),
    );
  }

  // String toJson() => json.encode(toMap());

  // factory MoodEntry.fromJson(String source) => MoodEntry.fromMap(json.decode(source) as Map<String, dynamic>);
}
